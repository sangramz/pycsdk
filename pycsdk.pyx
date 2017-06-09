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
        # some errors are warnings (NO_TXT_WARN and ZONE_NOTFOUND_WARN) and are not reported
        if rc != 0 and rc != 0x0004C902 and rc != 0x0004C905:
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
        cdef RECERR rc
        cdef LPCTSTR pFilePath = file_path
        with nogil:
            rc = kRecOpenImgFile(pFilePath, &self.handle, 0, FF_TIFNO)
        CSDK.check_err(rc, 'kRecOpenImgFile')
        cdef int n
        with nogil:
            rc = kRecGetImgFilePageCount(self.handle, &n)
        CSDK.check_err(rc, 'kRecGetImgFilePageCount')
        self.nb_pages = n

    def close(self):
        cdef RECERR rc
        if self.handle != NULL:
            with nogil:
                rc = kRecCloseImgFile(self.handle)
            CSDK.check_err(rc, 'kRecCloseImgFile')
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
    switcher = {
        LANG_ALL: "LANG_ALL",
        LANG_ALL_LATIN: "LANG_ALL_LATIN",
        LANG_ALL_ASIAN: "LANG_ALL_ASIAN",
        LANG_START: "LANG_START",
        LANG_UD: "LANG_UD",
        LANG_AUTO: "LANG_AUTO",
        LANG_NO: "LANG_NO",
        LANG_ENG: "LANG_ENG",
        LANG_GER: "LANG_GER",
        LANG_FRE: "LANG_FRE",
        LANG_DUT: "LANG_DUT",
        LANG_NOR: "LANG_NOR",
        LANG_SWE: "LANG_SWE",
        LANG_FIN: "LANG_FIN",
        LANG_DAN: "LANG_DAN",
        LANG_ICE: "LANG_ICE",
        LANG_POR: "LANG_POR",
        LANG_SPA: "LANG_SPA",
        LANG_CAT: "LANG_CAT",
        LANG_GAL: "LANG_GAL",
        LANG_ITA: "LANG_ITA",
        LANG_MAL: "LANG_MAL",
        LANG_GRE: "LANG_GRE",
        LANG_POL: "LANG_POL",
        LANG_CZH: "LANG_CZH",
        LANG_SLK: "LANG_SLK",
        LANG_HUN: "LANG_HUN",
        LANG_SLN: "LANG_SLN",
        LANG_CRO: "LANG_CRO",
        LANG_ROM: "LANG_ROM",
        LANG_ALB: "LANG_ALB",
        LANG_TUR: "LANG_TUR",
        LANG_EST: "LANG_EST",
        LANG_LAT: "LANG_LAT",
        LANG_LIT: "LANG_LIT",
        LANG_ESP: "LANG_ESP",
        LANG_SRL: "LANG_SRL",
        LANG_SRB: "LANG_SRB",
        LANG_MAC: "LANG_MAC",
        LANG_MOL: "LANG_MOL",
        LANG_BUL: "LANG_BUL",
        LANG_BEL: "LANG_BEL",
        LANG_UKR: "LANG_UKR",
        LANG_RUS: "LANG_RUS",
        LANG_CHE: "LANG_CHE",
        LANG_KAB: "LANG_KAB",
        LANG_AFR: "LANG_AFR",
        LANG_AYM: "LANG_AYM",
        LANG_BAS: "LANG_BAS",
        LANG_BEM: "LANG_BEM",
        LANG_BLA: "LANG_BLA",
        LANG_BRE: "LANG_BRE",
        LANG_BRA: "LANG_BRA",
        LANG_BUG: "LANG_BUG",
        LANG_CHA: "LANG_CHA",
        LANG_CHU: "LANG_CHU",
        LANG_COR: "LANG_COR",
        LANG_CRW: "LANG_CRW",
        LANG_ESK: "LANG_ESK",
        LANG_FAR: "LANG_FAR",
        LANG_FIJ: "LANG_FIJ",
        LANG_FRI: "LANG_FRI",
        LANG_FRU: "LANG_FRU",
        LANG_GLI: "LANG_GLI",
        LANG_GLS: "LANG_GLS",
        LANG_GAN: "LANG_GAN",
        LANG_GUA: "LANG_GUA",
        LANG_HAN: "LANG_HAN",
        LANG_HAW: "LANG_HAW",
        LANG_IDO: "LANG_IDO",
        LANG_IND: "LANG_IND",
        LANG_INT: "LANG_INT",
        LANG_KAS: "LANG_KAS",
        LANG_KAW: "LANG_KAW",
        LANG_KIK: "LANG_KIK",
        LANG_KON: "LANG_KON",
        LANG_KPE: "LANG_KPE",
        LANG_KUR: "LANG_KUR",
        LANG_LTN: "LANG_LTN",
        LANG_LUB: "LANG_LUB",
        LANG_LUX: "LANG_LUX",
        LANG_MLG: "LANG_MLG",
        LANG_MLY: "LANG_MLY",
        LANG_MLN: "LANG_MLN",
        LANG_MAO: "LANG_MAO",
        LANG_MAY: "LANG_MAY",
        LANG_MIA: "LANG_MIA",
        LANG_MIN: "LANG_MIN",
        LANG_MOH: "LANG_MOH",
        LANG_NAH: "LANG_NAH",
        LANG_NYA: "LANG_NYA",
        LANG_OCC: "LANG_OCC",
        LANG_OJI: "LANG_OJI",
        LANG_PAP: "LANG_PAP",
        LANG_PID: "LANG_PID",
        LANG_PRO: "LANG_PRO",
        LANG_QUE: "LANG_QUE",
        LANG_RHA: "LANG_RHA",
        LANG_ROY: "LANG_ROY",
        LANG_RUA: "LANG_RUA",
        LANG_RUN: "LANG_RUN",
        LANG_SAM: "LANG_SAM",
        LANG_SAR: "LANG_SAR",
        LANG_SHO: "LANG_SHO",
        LANG_SIO: "LANG_SIO",
        LANG_SMI: "LANG_SMI",
        LANG_SML: "LANG_SML",
        LANG_SMN: "LANG_SMN",
        LANG_SMS: "LANG_SMS",
        LANG_SOM: "LANG_SOM",
        LANG_SOT: "LANG_SOT",
        LANG_SUN: "LANG_SUN",
        LANG_SWA: "LANG_SWA",
        LANG_SWZ: "LANG_SWZ",
        LANG_TAG: "LANG_TAG",
        LANG_TAH: "LANG_TAH",
        LANG_TIN: "LANG_TIN",
        LANG_TON: "LANG_TON",
        LANG_TUN: "LANG_TUN",
        LANG_VIS: "LANG_VIS",
        LANG_WEL: "LANG_WEL",
        LANG_WEN: "LANG_WEN",
        LANG_WOL: "LANG_WOL",
        LANG_XHO: "LANG_XHO",
        LANG_ZAP: "LANG_ZAP",
        LANG_ZUL: "LANG_ZUL",
        LANG_JPN: "LANG_JPN",
        LANG_CHS: "LANG_CHS",
        LANG_CHT: "LANG_CHT",
        LANG_KRN: "LANG_KRN",
        LANG_THA: "LANG_THA",
        LANG_ARA: "LANG_ARA",
        LANG_HEB: "LANG_HEB"
    }
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
                  letter.cellNum, letter.zone, code, choices, switcher.get(letter.lang, 'UNKNOWN_{}'.format(letter.lang)), confidence,
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


cdef build_rotation(IMG_ROTATE img_rotate):
    switcher = {
        ROT_AUTO: "ROT_AUTO",
        ROT_NO: "ROT_NO",
        ROT_RIGHT: "ROT_RIGHT",
        ROT_DOWN: "ROT_DOWN",
        ROT_LEFT: "ROT_LEFT",
        ROT_FLIPPED: "ROT_FLIPPED",
        ROT_RIGHT_FLIPPED: "ROT_RIGHT_FLIPPED",
        ROT_DOWN_FLIPPED: "ROT_DOWN_FLIPPED",
        ROT_LEFT_FLIPPED: "ROT_LEFT_FLIPPED"
    }
    return switcher.get(img_rotate, 'UNKNOWN_{}'.format(img_rotate))


cdef class Page:
    cdef CSDK sdk
    cdef HPAGE handle
    cdef public:
        object page_id
        object zones
        object letters
        object image
        object image_dpi
        object image_rotation

    def __cinit__(self, File file, page_id):
        self.sdk = file.sdk
        self.page_id = page_id
        self.handle = NULL
        cdef RECERR rc
        cdef int iPage = page_id
        with nogil:
            rc = kRecLoadImg(self.sdk.sid, file.handle, &self.handle, iPage)
        CSDK.check_err(rc, 'kRecLoadImg')

    def close(self):
        cdef RECERR rc
        if self.handle != NULL:
            # free image and recognition data
            with nogil:
                rc = kRecFreeImg(self.handle)
            CSDK.check_err(rc, 'kRecFreeImg')
        self.handle = NULL

    def __dealloc__(self):
        self.close()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass
        
    def process(self):
        # preprocess image and perform recognition
        cdef RECERR rc
        with nogil:
            rc = kRecPreprocessImg(self.sdk.sid, self.handle)
        CSDK.check_err(rc, 'kRecPreprocessImg')
        cdef PREPROC_INFO preproc_info;
        with nogil:
            rc = kRecGetPreprocessInfo(self.handle, &preproc_info)
        CSDK.check_err(rc, 'kRecGetPreprocessInfo')
        self.image_rotation = build_rotation(preproc_info.Rotation)        
        with nogil:
            rc = kRecRecognize(self.sdk.sid, self.handle, NULL)
        CSDK.check_err(rc, 'kRecRecognize')
        
        # retrieve image
        cdef IMG_INFO img_info
        cdef LPBYTE bitmap
        with nogil:
            rc = kRecGetImgArea(self.sdk.sid, self.handle, II_CURRENT, NULL, NULL, &img_info, &bitmap)
        CSDK.check_err(rc, 'kRecGetImgArea')
        cdef PyObject* o = PyBytes_FromStringAndSize(<const char*> bitmap, img_info.BytesPerLine * img_info.Size.cy)
        bytes = <object> o
        with nogil:
            rc = kRecFree(bitmap)
        CSDK.check_err(rc, 'kRecFree')
        size = (img_info.Size.cx, img_info.Size.cy)
        cdef BYTE[768] palette
        if img_info.IsPalette == 1:
            CSDK.check_err(kRecGetImgPalette(self.sdk.sid, self.handle, II_CURRENT, palette), 'kRecGetImgPalette')
        if img_info.BitsPerPixel == 1:
            self.image = Image.frombuffer('1', (img_info.BytesPerLine * 8, img_info.Size.cy), bytes, 'raw', '1;I', 0, 1)
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 0:
            self.image = Image.frombuffer('L', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'L', img_info.BytesPerLine, 1)
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 1:
            self.image = Image.frombuffer('P', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'P', img_info.BytesPerLine, 1)
            o = PyBytes_FromStringAndSize(<const char*> palette, sizeof(palette))
            palette_bytes = <object> o
            self.image.putpalette(palette_bytes)
        elif img_info.BitsPerPixel == 24:
            self.image = Image.frombuffer('RGB', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'RGB', img_info.BytesPerLine, 1)
        else:
            raise Exception('OmniPage: unsupported number of bits per pixel: {}'.format(img_info.BitsPerPixel))
        self.image_dpi = (img_info.DPI.cx, img_info.DPI.cy)

        # retrieve OCR zones
        cdef int nb_zones
        with nogil:
            rc = kRecGetOCRZoneCount(self.handle, &nb_zones)
        CSDK.check_err(rc, 'kRecGetOCRZoneCount')
        self.zones = []
        cdef ZONE zone
        for zone_id in range(nb_zones):
            with nogil:
                rc = kRecGetOCRZoneInfo(self.handle, II_CURRENT, &zone, zone_id)
            CSDK.check_err(rc, 'kRecGetOCRZoneInfo')
            self.zones.append(build_zone(zone))

        # retrieve letter choices
        cdef LPWCH pChoices
        cdef LONG nbChoices
        with nogil:
            rc = kRecGetChoiceStr(self.handle, &pChoices, &nbChoices)
        CSDK.check_err(rc, 'kRecGetChoiceStr')

        # retrieve letters
        cdef LPLETTER pLetters
        cdef LONG nb_letters
        with nogil:
            rc = kRecGetLetters(self.handle, II_CURRENT, &pLetters, &nb_letters)
        CSDK.check_err(rc, 'kRecGetLetters')
        self.letters = []
        for letter_id in range(nb_letters):
            letter = build_letter(pLetters[letter_id], pChoices, img_info.DPI.cy)
            if letter is not None:
                self.letters.append(letter)
                
        # cleanup
        with nogil:
            rc = kRecFree(pLetters)
        CSDK.check_err(rc, 'kRecFree')
        with nogil:
            rc = kRecFree(pChoices)
        CSDK.check_err(rc, 'kRecFree')
        
