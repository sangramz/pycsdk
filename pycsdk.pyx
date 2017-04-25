# cython: c_string_type=str, c_string_encoding=ascii

import os
from cpython.mem cimport PyMem_Malloc, PyMem_Free
from libc.stdlib cimport malloc, free
from cpython.ref cimport PyObject
from PIL import Image


cdef extern from "Python.h":
    cdef int PyUnicode_2BYTE_KIND "PyUnicode_2BYTE_KIND"
    PyObject* PyUnicode_FromKindAndData(int kind, const void *buffer, Py_ssize_t size)
    PyObject* PyBytes_FromStringAndSize(const char *v, Py_ssize_t len)

SID = 0


cdef class CSDK:
        
    @staticmethod
    def check_err(rc, api_function):
        if rc != 0:
            raise Exception('OmniPage: {} error: {:08x}'.format(api_function, rc))

    def __cinit__(self,  company_name, product_name):
        cdef LPCSTR pCompanyName = company_name
        cdef LPCSTR pProductName = product_name
        CSDK.check_err(RecInitPlus(pCompanyName, pProductName), 'RecInitPlus')
        
        # output files as UTF-8 without BOM
        CSDK.check_err(kRecSetCodePage(SID, 'UTF-8'), 'kRecSetCodePage')
        self.set_setting('Kernel.DTxt.UnicodeFileHeader', '')
        self.set_setting('Kernel.DTxt.txt.LineBreak', '\n')
        
        # enable all languages
        CSDK.check_err(kRecManageLanguages(SID, SET_LANG, LANG_ALL_LATIN), 'kRecManageLanguages')
        
        # keep original image colors
        #CSDK.check_err(kRecSetImgConvMode(SID, CNV_NO), 'kRecSetImgConvMode')
        

    def __dealloc__(self):
        CSDK.check_err(RecQuitPlus(), 'RecQuitPlus')

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def set_setting(self, setting_name, setting_value):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise Exception('OmniPage: unknown setting')
        if isinstance(setting_value, int):
            CSDK.check_err(kRecSettingSetInt(SID, setting, setting_value), 'kRecSettingSetInt');
        elif isinstance(setting_value, str):
            CSDK.check_err(kRecSettingSetString(SID, setting, setting_value), 'kRecSettingSetString');
        else:
            raise Exception('OmniPage: unsupported setting value type: {}'.format(setting_value))

    def get_setting_int(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise Exception('OmniPage: unknown setting')
        cdef int setting_value
        CSDK.check_err(kRecSettingGetInt(SID, setting, &setting_value), 'kRecSettingGetInt');
        return setting_value

    def get_setting_string(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise Exception('OmniPage: unknown setting')
        cdef const WCHAR* setting_value
        CSDK.check_err(kRecSettingGetUString(SID, setting, &setting_value), 'kRecSettingGetUString');
        length = 0
        while setting_value[length] != 0:
            length += 1
        cdef PyObject* o = PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, setting_value, length)
        return <object> o

    def set_rm_tradeoff(self, tradeoff):
        CSDK.check_err(kRecSetRMTradeoff(SID, tradeoff), 'kRecSetRMTradeoff')

    def set_single_language_detection(self, flag):
        cdef INTBOOL setting = 1 if flag == True else 0       
        CSDK.check_err(kRecSetSingleLanguageDetection(SID, setting), 'kRecSetSingleLanguageDetection')
        
    def open_file(self, file_path):
        return File(self, file_path)


cdef class File:
    cdef CSDK sdk
    cdef HIMGFILE handle
    cdef public:
        object nb_pages

    def __cinit__(self, CSDK sdk, file_path):
        self.sdk = sdk
        CSDK.check_err(kRecOpenImgFile(file_path, &self.handle, 0, FF_TIFNO), 'kRecOpenImgFile')
        cdef int n
        CSDK.check_err(kRecGetImgFilePageCount(self.handle, &n), 'kRecGetImgFilePageCount')
        self.nb_pages = n

    def __dealloc__(self):
        CSDK.check_err(kRecCloseImgFile(self.handle), 'kRecCloseImgFile')

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def open_page(self, page_id):
        return Page(self, page_id)
        
cdef class Letter:
    cdef public:
        object top
        object left
        object bottom
        object right
        object font_size
        object cell_num
        object zone_index
        object code
        object choices

    def __cinit__(self, LETTER letter, choices, dpi):
        self.top = letter.top
        self.left = letter.left
        self.bottom = letter.top + letter.height
        self.right = letter.left + letter.width
        self.font_size = letter.capHeight * 100.0 / dpi
        self.cell_num = letter.cellNum
        self.zone_index = letter.zone
        cdef PyObject* o
        cdef WCHAR* code = &letter.code
        self.code = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, code, 1)
        self.choices = choices
            
    def __dealloc__(self):
        pass

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass

    @staticmethod 
    cdef build(LETTER letter, LPWCH pChoices, dpi):
        if letter.code == 0x0fffd: #UNICODE_REJECTED
            return None
        else:
            choices = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pChoices + letter.ndxChoices, letter.cntChoices)
            return Letter(letter, choices, dpi)
     
  
cdef class Page:
    cdef CSDK sdk
    cdef HPAGE handle
    cdef public:
        object page_id
        object zones
        object letters
        object image

    def __cinit__(self, File file, page_id):
        self.sdk = file.sdk
        self.page_id = page_id
        CSDK.check_err(kRecLoadImg(SID, file.handle, &self.handle, page_id), 'kRecLoadImg')

    def __dealloc__(self):
        CSDK.check_err(kRecFreeImg(self.handle), 'kRecFreeImg')

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def process(self):
        # preprocess image, locate zones and perform recognition
        CSDK.check_err(kRecPreprocessImg(SID, self.handle), 'kRecPreprocessImg')
        CSDK.check_err(kRecLocateZones(SID, self.handle), 'kRecLocateZones')
        CSDK.check_err(kRecRecognize(SID, self.handle, NULL), 'kRecRecognize')
        
        # retrieve image
        cdef IMG_INFO img_info
        cdef LPBYTE bitmap
        CSDK.check_err(kRecGetImgArea(SID, self.handle, II_CURRENT, NULL, NULL, &img_info, &bitmap), 'kRecGetImgArea')
        cdef PyObject* o = PyBytes_FromStringAndSize(<const char*> bitmap, img_info.BytesPerLine * img_info.Size.cy)
        bytes = <object> o
        CSDK.check_err(kRecFree(bitmap), 'kRecFree')
        size = (img_info.Size.cx, img_info.Size.cy)
        cdef BYTE[768] palette
        if img_info.IsPalette == 1:
            CSDK.check_err(kRecGetImgPalette(SID, self.handle, II_CURRENT, palette), 'kRecGetImgPalette')
        if img_info.BitsPerPixel == 1:
            self.image = Image.frombuffer('1', (img_info.BytesPerLine * 8, img_info.Size.cy), bytes, 'raw', '1;I', 0, 1)
        elif img_info.BitsPerPixel == 8:
            # TODO use palette
            self.image = Image.frombuffer('P', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'P', 0, 1)
        elif img_info.BitsPerPixel == 24:
            self.image = Image.frombuffer('RGB', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'RGB', 0, 1)
        else:
            raise Exception('OmniPage: unsupported number of bits per pixel: {}'.format(img_info.BitsPerPixel))

        # retrieve OCR zones
        cdef int nb_zones
        CSDK.check_err(kRecGetOCRZoneCount(self.handle, &nb_zones), 'kRecGetOCRZoneCount')
        self.zones = []
        cdef ZONE zone
        for zone_id in range(nb_zones):
            CSDK.check_err(kRecGetOCRZoneInfo(self.handle, II_CURRENT, &zone, zone_id), 'kRecGetOCRZoneInfo')
            self.zones.append(zone.copy())

        # retrieve letter choices
        cdef LPWCH pChoices
        cdef LONG nbChoices
        CSDK.check_err(kRecGetChoiceStr(self.handle, &pChoices, &nbChoices), 'kRecGetChoiceStr')

        # retrieve letters
        cdef LPLETTER pLetters
        cdef LONG nb_letters
        CSDK.check_err(kRecGetLetters(self.handle, II_CURRENT, &pLetters, &nb_letters), 'kRecGetLetters')
        self.letters = []
        for letter_id in range(nb_letters):
            letter = Letter.build(pLetters[letter_id], pChoices, img_info.DPI.cy)
            if letter is not None:
                self.letters.append(letter)
                
        # cleanup
        CSDK.check_err(kRecFree(pLetters), 'kRecFree')
        CSDK.check_err(kRecFree(pChoices), 'kRecFree')
