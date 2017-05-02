# cython: c_string_type=str, c_string_encoding=ascii

import os
from cpython.mem cimport PyMem_Malloc, PyMem_Free
from libc.stdlib cimport malloc, free
from cpython.ref cimport PyObject
from PIL import Image
from pprint import pformat
from threading import RLock


cdef extern from "Python.h":
    cdef int PyUnicode_2BYTE_KIND "PyUnicode_2BYTE_KIND"
    PyObject* PyUnicode_FromKindAndData(int kind, const void *buffer, Py_ssize_t size)
    PyObject* PyBytes_FromStringAndSize(const char *v, Py_ssize_t len)

csdk_lock = RLock()
nb_csdk_instances = 0


cdef class CSDK:
    cdef int sid
    cdef int initialized
    
    @staticmethod
    def check_err(rc, api_function):
        if rc != 0:
            raise Exception('OmniPage: {} error: {:08x}'.format(api_function, rc))

    def __cinit__(self,  company_name, product_name):
        global nb_csdk_instances
        self.sid = -1
        self.initialized = 0
        with csdk_lock:
            if nb_csdk_instances == 0:
                CSDK.check_err(RecInitPlus(company_name, product_name), 'RecInitPlus')
            nb_csdk_instances += 1
        self.initialized = 1

        # create a settings collection for this CSDK instance
        self.sid = kRecCreateSettingsCollection(-1)
        
        # output files as UTF-8 without BOM
        CSDK.check_err(kRecSetCodePage(self.sid, 'UTF-8'), 'kRecSetCodePage')
        self.set_setting('Kernel.DTxt.UnicodeFileHeader', '')
        self.set_setting('Kernel.DTxt.txt.LineBreak', '\n')
        
        # enable all languages
        CSDK.check_err(kRecManageLanguages(self.sid, SET_LANG, LANG_ALL_LATIN), 'kRecManageLanguages')        

    def __dealloc__(self):
        global nb_csdk_instances
        if self.sid != -1:
            CSDK.check_err(kRecDeleteSettingsCollection(self.sid), 'kRecDeleteSettingsCollection')
        if self.initialized != 0:
            with csdk_lock:
                nb_csdk_instances -= 1
                if nb_csdk_instances == 0:
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
            CSDK.check_err(kRecSettingSetInt(self.sid, setting, setting_value), 'kRecSettingSetInt');
        elif isinstance(setting_value, str):
            CSDK.check_err(kRecSettingSetString(self.sid, setting, setting_value), 'kRecSettingSetString');
        else:
            raise Exception('OmniPage: unsupported setting value type: {}'.format(setting_value))

    def get_setting_int(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise Exception('OmniPage: unknown setting')
        cdef int setting_value
        CSDK.check_err(kRecSettingGetInt(self.sid, setting, &setting_value), 'kRecSettingGetInt');
        return setting_value

    def get_setting_string(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise Exception('OmniPage: unknown setting')
        cdef const WCHAR* setting_value
        CSDK.check_err(kRecSettingGetUString(self.sid, setting, &setting_value), 'kRecSettingGetUString');
        length = 0
        while setting_value[length] != 0:
            length += 1
        cdef PyObject* o = PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, setting_value, length)
        return <object> o

    def set_rm_tradeoff(self, tradeoff):
        CSDK.check_err(kRecSetRMTradeoff(self.sid, tradeoff), 'kRecSetRMTradeoff')

    def set_single_language_detection(self, flag):
        cdef INTBOOL setting = 1 if flag == True else 0       
        CSDK.check_err(kRecSetSingleLanguageDetection(self.sid, setting), 'kRecSetSingleLanguageDetection')
        
    def open_file(self, file_path):
        return File(self, file_path)


cdef class File:
    cdef CSDK sdk
    cdef HIMGFILE handle
    cdef public:
        object nb_pages

    def __cinit__(self, CSDK sdk, file_path):
        self.sdk = sdk
        self.handle = NULL
        CSDK.check_err(kRecOpenImgFile(file_path, &self.handle, 0, FF_TIFNO), 'kRecOpenImgFile')
        cdef int n
        CSDK.check_err(kRecGetImgFilePageCount(self.handle, &n), 'kRecGetImgFilePageCount')
        self.nb_pages = n

    def close(self):
        if self.handle != NULL:
            CSDK.check_err(kRecCloseImgFile(self.handle), 'kRecCloseImgFile')
        self.handle = NULL

    def __dealloc__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def open_page(self, page_id):
        return Page(self, page_id)
        

class Letter:
    def __init__(self, top, left, bottom, right, font_size, cell_num, zone_id, code, choices, lang, confidence,
                 italic, bold, end_word, end_line, end_cell, end_row, in_cell):
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.font_size = font_size
        self.cell_num = cell_num
        self.zone_id = zone_id
        self.code = code
        self.choices = choices
        self.lang = lang
        self.confidence = confidence
        self.italic = italic
        self.bold = bold
        self.end_word = end_word
        self.end_line = end_line
        self.end_cell = end_cell
        self.end_row = end_row
        self.in_cell = in_cell
            
    def __repr__(self):
        return pformat(vars(self))


cdef build_letter(LETTER letter, LPWCH pChoices, dpi):
    if letter.code == 0x0fffd or letter.width == 0: # UNICODE_REJECTED and dummy space
        return None
    cdef WCHAR* pCode = &letter.code
    code = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pCode, 1)
    if letter.cntChoices > 1:
        choices = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pChoices + letter.ndxChoices, letter.cntChoices - 1)
    else:
        choices = ''
    cdef BYTE err = letter.err
    if err >= 100:
        confidence = 0
    else:
        confidence = 100 - err
    italic = True if letter.fontAttrib & 0x0002 else False
    bold = True if letter.fontAttrib & 0x0008 else False
    end_word = True if letter.makeup & 0x0004 else False
    end_line = True if letter.makeup & 0x0001 else False
    end_cell = True if letter.makeup & 0x0020 else False
    end_row = True if letter.makeup & 0x0040 else False
    in_cell = True if letter.makeup & 0x0080 else False
    return Letter(letter.top, letter.left, letter.top + letter.height, letter.left + letter.width, letter.capHeight * 100.0 / dpi,
                  letter.cellNum, letter.zone, code, choices, letter.lang, confidence,
                  italic, bold, end_word, end_line, end_cell, end_row, in_cell)


class Zone:
    def __init__(self, top, left, bottom, right, type):
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.type = type

    def __repr__(self):
        return pformat(vars(self))


cdef build_zone(ZONE zone):
    switcher = {
        WT_FLOW: "WT_FLOW",
        WT_TABLE: "WT_TABLE",
        WT_GRAPHIC: "WT_GRAPHIC",
        WT_AUTO: "WT_AUTO",
        WT_IGNORE: "WT_IGNORE",
        WT_FORM: "WT_FORM",
        WT_VERTTEXT: "WT_VERTTEXT",
        WT_LEFTTEXT: "WT_LEFTTEXT",
        WT_RIGHTTEXT: "WT_RIGHTTEXT"
    }
    return Zone(zone.rectBBox.top, zone.rectBBox.left, zone.rectBBox.bottom, zone.rectBBox.right,
                switcher.get(zone.type, 'UNKNOWN_'.format(zone.type)))


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
        self.handle = NULL
        CSDK.check_err(kRecLoadImg(self.sdk.sid, file.handle, &self.handle, page_id), 'kRecLoadImg')

    def close(self):
        if self.handle != NULL:
            # free image and recognition data
            CSDK.check_err(kRecFreeImg(self.handle), 'kRecFreeImg')
        self.handle = NULL

    def __dealloc__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def process(self):
        # preprocess image and perform recognition
        CSDK.check_err(kRecPreprocessImg(self.sdk.sid, self.handle), 'kRecPreprocessImg')
        CSDK.check_err(kRecRecognize(self.sdk.sid, self.handle, NULL), 'kRecRecognize')
        
        # retrieve image
        cdef IMG_INFO img_info
        cdef LPBYTE bitmap
        CSDK.check_err(kRecGetImgArea(self.sdk.sid, self.handle, II_CURRENT, NULL, NULL, &img_info, &bitmap), 'kRecGetImgArea')
        cdef PyObject* o = PyBytes_FromStringAndSize(<const char*> bitmap, img_info.BytesPerLine * img_info.Size.cy)
        bytes = <object> o
        CSDK.check_err(kRecFree(bitmap), 'kRecFree')
        size = (img_info.Size.cx, img_info.Size.cy)
        cdef BYTE[768] palette
        if img_info.IsPalette == 1:
            CSDK.check_err(kRecGetImgPalette(self.sdk.sid, self.handle, II_CURRENT, palette), 'kRecGetImgPalette')
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
            self.zones.append(build_zone(zone))

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
            letter = build_letter(pLetters[letter_id], pChoices, img_info.DPI.cy)
            if letter is not None:
                self.letters.append(letter)
                
        # cleanup
        CSDK.check_err(kRecFree(pLetters), 'kRecFree')
        CSDK.check_err(kRecFree(pChoices), 'kRecFree')
        
