# cython: c_string_type=str, c_string_encoding=ascii

import os
import tempfile
from cpython.ref cimport PyObject
from cpython.float cimport PyFloat_FromDouble
from PIL import Image
from pprint import pformat
from threading import RLock, local
from contextlib import contextmanager
from datetime import datetime


cdef extern from "Python.h":
    cdef int PyUnicode_2BYTE_KIND "PyUnicode_2BYTE_KIND"
    PyObject* PyUnicode_FromKindAndData(int kind, const void *buffer, Py_ssize_t size)
    PyObject* PyBytes_FromStringAndSize(const char *v, Py_ssize_t len)

csdk_lock = RLock()
nb_csdk_instances = 0
local_data = local()


class TwoWayDict(dict):
    def __setitem__(self, key, value):
        if key in self:
            del self[key]
        if value in self:
            del self[value]
        dict.__setitem__(self, key, value)
        dict.__setitem__(self, value, key)

    def __delitem__(self, key):
        dict.__delitem__(self, self[key])
        dict.__delitem__(self, key)

    def __len__(self):
        return dict.__len__(self) // 2


lang_dict = TwoWayDict()
lang_dict[LANG_ALL] = 'LANG_ALL'
lang_dict[LANG_ALL_LATIN] = 'LANG_ALL_LATIN'
lang_dict[LANG_ALL_ASIAN] = 'LANG_ALL_ASIAN'
lang_dict[LANG_START] = 'LANG_START'
lang_dict[LANG_UD] = 'LANG_UD'
lang_dict[LANG_AUTO] = 'LANG_AUTO'
lang_dict[LANG_NO] = 'LANG_NO'
lang_dict[LANG_ENG] = 'LANG_ENG'
lang_dict[LANG_GER] = 'LANG_GER'
lang_dict[LANG_FRE] = 'LANG_FRE'
lang_dict[LANG_DUT] = 'LANG_DUT'
lang_dict[LANG_NOR] = 'LANG_NOR'
lang_dict[LANG_SWE] = 'LANG_SWE'
lang_dict[LANG_FIN] = 'LANG_FIN'
lang_dict[LANG_DAN] = 'LANG_DAN'
lang_dict[LANG_ICE] = 'LANG_ICE'
lang_dict[LANG_POR] = 'LANG_POR'
lang_dict[LANG_SPA] = 'LANG_SPA'
lang_dict[LANG_CAT] = 'LANG_CAT'
lang_dict[LANG_GAL] = 'LANG_GAL'
lang_dict[LANG_ITA] = 'LANG_ITA'
lang_dict[LANG_MAL] = 'LANG_MAL'
lang_dict[LANG_GRE] = 'LANG_GRE'
lang_dict[LANG_POL] = 'LANG_POL'
lang_dict[LANG_CZH] = 'LANG_CZH'
lang_dict[LANG_SLK] = 'LANG_SLK'
lang_dict[LANG_HUN] = 'LANG_HUN'
lang_dict[LANG_SLN] = 'LANG_SLN'
lang_dict[LANG_CRO] = 'LANG_CRO'
lang_dict[LANG_ROM] = 'LANG_ROM'
lang_dict[LANG_ALB] = 'LANG_ALB'
lang_dict[LANG_TUR] = 'LANG_TUR'
lang_dict[LANG_EST] = 'LANG_EST'
lang_dict[LANG_LAT] = 'LANG_LAT'
lang_dict[LANG_LIT] = 'LANG_LIT'
lang_dict[LANG_ESP] = 'LANG_ESP'
lang_dict[LANG_SRL] = 'LANG_SRL'
lang_dict[LANG_SRB] = 'LANG_SRB'
lang_dict[LANG_MAC] = 'LANG_MAC'
lang_dict[LANG_MOL] = 'LANG_MOL'
lang_dict[LANG_BUL] = 'LANG_BUL'
lang_dict[LANG_BEL] = 'LANG_BEL'
lang_dict[LANG_UKR] = 'LANG_UKR'
lang_dict[LANG_RUS] = 'LANG_RUS'
lang_dict[LANG_CHE] = 'LANG_CHE'
lang_dict[LANG_KAB] = 'LANG_KAB'
lang_dict[LANG_AFR] = 'LANG_AFR'
lang_dict[LANG_AYM] = 'LANG_AYM'
lang_dict[LANG_BAS] = 'LANG_BAS'
lang_dict[LANG_BEM] = 'LANG_BEM'
lang_dict[LANG_BLA] = 'LANG_BLA'
lang_dict[LANG_BRE] = 'LANG_BRE'
lang_dict[LANG_BRA] = 'LANG_BRA'
lang_dict[LANG_BUG] = 'LANG_BUG'
lang_dict[LANG_CHA] = 'LANG_CHA'
lang_dict[LANG_CHU] = 'LANG_CHU'
lang_dict[LANG_COR] = 'LANG_COR'
lang_dict[LANG_CRW] = 'LANG_CRW'
lang_dict[LANG_ESK] = 'LANG_ESK'
lang_dict[LANG_FAR] = 'LANG_FAR'
lang_dict[LANG_FIJ] = 'LANG_FIJ'
lang_dict[LANG_FRI] = 'LANG_FRI'
lang_dict[LANG_FRU] = 'LANG_FRU'
lang_dict[LANG_GLI] = 'LANG_GLI'
lang_dict[LANG_GLS] = 'LANG_GLS'
lang_dict[LANG_GAN] = 'LANG_GAN'
lang_dict[LANG_GUA] = 'LANG_GUA'
lang_dict[LANG_HAN] = 'LANG_HAN'
lang_dict[LANG_HAW] = 'LANG_HAW'
lang_dict[LANG_IDO] = 'LANG_IDO'
lang_dict[LANG_IND] = 'LANG_IND'
lang_dict[LANG_INT] = 'LANG_INT'
lang_dict[LANG_KAS] = 'LANG_KAS'
lang_dict[LANG_KAW] = 'LANG_KAW'
lang_dict[LANG_KIK] = 'LANG_KIK'
lang_dict[LANG_KON] = 'LANG_KON'
lang_dict[LANG_KPE] = 'LANG_KPE'
lang_dict[LANG_KUR] = 'LANG_KUR'
lang_dict[LANG_LTN] = 'LANG_LTN'
lang_dict[LANG_LUB] = 'LANG_LUB'
lang_dict[LANG_LUX] = 'LANG_LUX'
lang_dict[LANG_MLG] = 'LANG_MLG'
lang_dict[LANG_MLY] = 'LANG_MLY'
lang_dict[LANG_MLN] = 'LANG_MLN'
lang_dict[LANG_MAO] = 'LANG_MAO'
lang_dict[LANG_MAY] = 'LANG_MAY'
lang_dict[LANG_MIA] = 'LANG_MIA'
lang_dict[LANG_MIN] = 'LANG_MIN'
lang_dict[LANG_MOH] = 'LANG_MOH'
lang_dict[LANG_NAH] = 'LANG_NAH'
lang_dict[LANG_NYA] = 'LANG_NYA'
lang_dict[LANG_OCC] = 'LANG_OCC'
lang_dict[LANG_OJI] = 'LANG_OJI'
lang_dict[LANG_PAP] = 'LANG_PAP'
lang_dict[LANG_PID] = 'LANG_PID'
lang_dict[LANG_PRO] = 'LANG_PRO'
lang_dict[LANG_QUE] = 'LANG_QUE'
lang_dict[LANG_RHA] = 'LANG_RHA'
lang_dict[LANG_ROY] = 'LANG_ROY'
lang_dict[LANG_RUA] = 'LANG_RUA'
lang_dict[LANG_RUN] = 'LANG_RUN'
lang_dict[LANG_SAM] = 'LANG_SAM'
lang_dict[LANG_SAR] = 'LANG_SAR'
lang_dict[LANG_SHO] = 'LANG_SHO'
lang_dict[LANG_SIO] = 'LANG_SIO'
lang_dict[LANG_SMI] = 'LANG_SMI'
lang_dict[LANG_SML] = 'LANG_SML'
lang_dict[LANG_SMN] = 'LANG_SMN'
lang_dict[LANG_SMS] = 'LANG_SMS'
lang_dict[LANG_SOM] = 'LANG_SOM'
lang_dict[LANG_SOT] = 'LANG_SOT'
lang_dict[LANG_SUN] = 'LANG_SUN'
lang_dict[LANG_SWA] = 'LANG_SWA'
lang_dict[LANG_SWZ] = 'LANG_SWZ'
lang_dict[LANG_TAG] = 'LANG_TAG'
lang_dict[LANG_TAH] = 'LANG_TAH'
lang_dict[LANG_TIN] = 'LANG_TIN'
lang_dict[LANG_TON] = 'LANG_TON'
lang_dict[LANG_TUN] = 'LANG_TUN'
lang_dict[LANG_VIS] = 'LANG_VIS'
lang_dict[LANG_WEL] = 'LANG_WEL'
lang_dict[LANG_WEN] = 'LANG_WEN'
lang_dict[LANG_WOL] = 'LANG_WOL'
lang_dict[LANG_XHO] = 'LANG_XHO'
lang_dict[LANG_ZAP] = 'LANG_ZAP'
lang_dict[LANG_ZUL] = 'LANG_ZUL'
lang_dict[LANG_JPN] = 'LANG_JPN'
lang_dict[LANG_CHS] = 'LANG_CHS'
lang_dict[LANG_CHT] = 'LANG_CHT'
lang_dict[LANG_KRN] = 'LANG_KRN'
lang_dict[LANG_THA] = 'LANG_THA'
lang_dict[LANG_ARA] = 'LANG_ARA'
lang_dict[LANG_HEB] = 'LANG_HEB'


class CSDKException(Exception):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)


cdef class CSDK:
    cdef int sid
    cdef int initialized

    @staticmethod
    def check_err(rc, api_function):
        # log warning, raise exception for error
        cdef RETCODEINFO err_info
        cdef LPCSTR err_sym
        if rc != 0:
            switcher = {
                RET_OK: "RET_OK",
                RET_WARNING: "RET_WARNING",
                RET_MEMORY_ERROR: "RET_MEMORY_ERROR",
                RET_FILE_ERROR: "RET_FILE_ERROR",
                RET_SCANNER_ERROR: "RET_SCANNER_ERROR",
                RET_IMAGE_ERROR: "RET_IMAGE_ERROR",
                RET_OCR_ERROR: "RET_OCR_ERROR",
                RET_TEXT_ERROR: "RET_TEXT_ERROR",
                RET_OTHER_ERROR: "RET_OTHER_ERROR",
                RET_UNKNOWN: "RET_UNKNOWN"
            }
            err_info = kRecGetErrorInfo(rc, &err_sym)
            if err_info == RET_WARNING:
                if not hasattr(local_data, 'warnings'):
                    local_data.warnings = []
                local_data.warnings.append('OmniPage: {} returned warning {:08x}: {}'.format(api_function, rc, err_sym))
            else:
                error_kind = switcher.get(err_info, 'UNKNOWN_{}'.format(err_info))
                raise CSDKException(
                    'OmniPage: {} returned error {:08x}: {} ({})'.format(api_function, rc, err_sym, error_kind))

    @staticmethod
    def warnings():
        result = []
        if hasattr(local_data, 'warnings'):
            result = local_data.warnings
            del local_data.warnings
        return result

    def __cinit__(self, company_name, product_name, license_file=None, code=None):
        global nb_csdk_instances
        self.sid = -1
        self.initialized = 0
        with csdk_lock:
            if nb_csdk_instances == 0:
                if license_file is not None and code is not None:
                    CSDK.check_err(kRecSetLicense(license_file, code), 'kRecSetLicense')
                CSDK.check_err(RecInitPlus(company_name, product_name), 'RecInitPlus')
            nb_csdk_instances += 1
        self.initialized = 1

        # create a settings collection for this CSDK instance
        self.sid = kRecCreateSettingsCollection(-1)

        # output files as UTF-8 without BOM
        CSDK.check_err(kRecSetCodePage(self.sid, 'UTF-8'), 'kRecSetCodePage')
        self.set_setting('Kernel.DTxt.UnicodeFileHeader', '')
        self.set_setting('Kernel.DTxt.txt.LineBreak', '\n')

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
            raise CSDKException('OmniPage: unknown setting "{}"'.format(setting_name))
        if isinstance(setting_value, int):
            CSDK.check_err(kRecSettingSetInt(self.sid, setting, setting_value), 'kRecSettingSetInt');
        elif isinstance(setting_value, str):
            CSDK.check_err(kRecSettingSetString(self.sid, setting, setting_value), 'kRecSettingSetString');
        else:
            raise CSDKException('OmniPage: unsupported setting value type: {}'.format(setting_value))

    def get_setting_int(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise CSDKException('OmniPage: unknown setting "{}"'.format(setting_name))
        cdef int setting_value
        CSDK.check_err(kRecSettingGetInt(self.sid, setting, &setting_value), 'kRecSettingGetInt');
        return setting_value

    def get_setting_string(self, setting_name):
        cdef HSETTING setting
        cdef INTBOOL hasSetting
        CSDK.check_err(kRecSettingGetHandle(NULL, setting_name, &setting, &hasSetting), 'kRecSettingGetHandle')
        if hasSetting == 0:
            raise CSDKException('OmniPage: unknown setting "{}"'.format(setting_name))
        cdef const WCHAR*setting_value
        CSDK.check_err(kRecSettingGetUString(self.sid, setting, &setting_value), 'kRecSettingGetUString');
        length = 0
        while setting_value[length] != 0:
            length += 1
        cdef PyObject*o = PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, setting_value, length)
        return <object> o

    def set_language(self, lang_code):
        cdef RECERR rc
        cdef LANGUAGES lang = lang_code
        with nogil:
            rc = kRecManageLanguages(self.sid, SET_LANG, lang)
        CSDK.check_err(rc, 'kRecManageLanguages')

    def add_language(self, lang_code):
        cdef RECERR rc
        cdef LANGUAGES lang = lang_code
        with nogil:
            rc = kRecManageLanguages(self.sid, ADD_LANG, lang)
        CSDK.check_err(rc, 'kRecManageLanguages')

    @staticmethod
    def get_lang_name(lang_code):
        return lang_dict[lang_code] if lang_code in lang_dict else None

    @staticmethod
    def get_lang_code(lang_name):
        return lang_dict[lang_name] if lang_name in lang_dict else None

    def open_file(self, file_path):
        return File(self, file_path)

    def create_file(self, file_path):
        return File(self, file_path, write_pdf=True)

cdef class File:
    cdef CSDK sdk
    cdef HIMGFILE handle
    cdef public:
        object read_only
        object nb_pages

    def __cinit__(self, CSDK sdk, file_path, write_pdf = False):
        self.sdk = sdk
        self.handle = NULL
        cdef RECERR rc
        cdef LPCTSTR pFilePath = file_path
        cdef int mode
        cdef IMF_FORMAT format
        if write_pdf:
            mode = 2  # IMGF_RDWR
            format = FF_PDF
            self.read_only = False
        else:
            mode = 0  # IMGF_READ
            format = FF_TIFNO  # 0, not used
            self.read_only = True
        with nogil:
            rc = kRecOpenImgFile(pFilePath, &self.handle, mode, format)
        CSDK.check_err(rc, 'kRecOpenImgFile')
        cdef int n
        if write_pdf:
            n = 0
        else:
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
        if self.read_only:
            return Page(self, page_id)
        else:
            raise NotImplementedError('not supported in read-write mode')

    # append an image to this output PDF file
    def add_page(self, image, format):
        if self.read_only:
            raise CSDKException('OmniPage: cannot add page to a read-only file')

        # save image to a temporary file
        tf = tempfile.NamedTemporaryFile(delete=False)
        cdef RECERR rc
        cdef LPCTSTR pFilePath = tf.name
        cdef HPAGE hPage
        try:
            with tf:
                image.save(tf, format)
            with nogil:
                rc = kRecLoadImgF(self.sdk.sid, pFilePath, &hPage, 0)
            CSDK.check_err(rc, 'kRecLoadImgF')
            with nogil:
                rc = kRecSaveImg(self.sdk.sid, self.handle, FF_PDF, hPage, II_ORIGINAL, 1)
            CSDK.check_err(rc, 'kRecSaveImg')
            with nogil:
                rc = kRecFreeImg(hPage)
            CSDK.check_err(rc, 'kRecFreeImg')
        finally:
            os.unlink(tf.name)


class Letter:
    def __init__(self, top, left, bottom, right, font_size, cell_num, zone_id, code, space_type, nb_spaces,
                 choices, suggestions, lang, lang2, dictionary_word, confidence, word_suspicious, italic, bold,
                 end_word, end_line, end_cell, end_row, in_cell, orientation, rtl):
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.font_size = font_size
        self.cell_num = cell_num
        self.zone_id = zone_id
        self.code = code
        self.nb_spaces = nb_spaces
        self.space_type = space_type
        self.choices = choices
        self.suggestions = suggestions
        self.lang = lang
        self.lang2 = lang2
        self.dictionary_word = dictionary_word
        self.confidence = confidence
        self.word_suspicious = word_suspicious
        self.italic = italic
        self.bold = bold
        self.end_word = end_word
        self.end_line = end_line
        self.end_cell = end_cell
        self.end_row = end_row
        self.in_cell = in_cell
        self.orientation = orientation
        self.rtl = rtl

    def __repr__(self):
        return pformat(vars(self))


cdef build_letter(LETTER letter, LPWCH pChoices, LPWCH pSuggestions, dpi):
    if letter.code == 0x0fffd:  # UNICODE_REJECTED
        return None
    cdef WCHAR*pCode = &letter.code
    code = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pCode, 1)
    if letter.cntChoices > 1:
        choices = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pChoices + letter.ndxChoices, letter.cntChoices - 1)
    else:
        choices = ''
    if letter.cntSuggestions > 1:
        suggestions = <object> PyUnicode_FromKindAndData(PyUnicode_2BYTE_KIND, pSuggestions + letter.ndxSuggestions, letter.cntSuggestions - 1)
    else:
        suggestions = ''
    nb_spaces = None
    space_type = None
    if code == ' ':
        nb_spaces = letter.spcInfo.spcCount
        spc_type = letter.spcInfo.spcType
        if spc_type == 0:
            space_type = 'SPC_SPACE'
        elif spc_type == 1:
            space_type = 'SPC_TAB'
        elif spc_type == 2:
            space_type = 'SPC_LEADERDOT'
        elif spc_type == 3:
            space_type = 'SPC_LEADERLINE'
        elif spc_type == 4:
            space_type = 'SPC_LEADERHYPHEN'
        else:
            space_type = 'UNKNOWN_{}'.format(spc_type)
    cdef BYTE err = letter.err
    word_suspicious = True if err & 0x80 else False
    err = err & 0x7f
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
    orientation = 'R_NORMTEXT'
    if letter.makeup & 0x0300 == 0x0300:
        orientation = 'R_RIGHTTEXT'
    elif letter.makeup & 0x0100 == 0x0100:
        orientation = 'R_VERTTEXT'
    elif letter.makeup & 0x0200 == 0x0200:
        orientation = 'R_LEFTTEXT'
    rtl = True if letter.makeup & 0x0400 else False
    lang = letter.lang
    lang = lang_dict[lang] if lang in lang_dict else None
    lang2 = letter.lang2
    lang2 = lang_dict[lang2] if lang2 in lang_dict else None
    dictionary_word = True if letter.info & 0x40000000 else False
    return Letter(letter.top, letter.left, letter.top + letter.height, letter.left + letter.width,
                  letter.capHeight * 100.0 / dpi,
                  letter.cellNum, letter.zone, code, space_type, nb_spaces, choices, suggestions,
                  lang, lang2, dictionary_word, confidence, word_suspicious,
                  italic, bold, end_word, end_line, end_cell, end_row, in_cell, orientation, rtl)

cdef zone_type(ZONETYPE type):
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
    return switcher.get(type, 'UNKNOWN_'.format(type))

cdef line_style(RLSTYLE style):
    switcher = {
        LS_NO: "LS_NO",
        LS_SOLID: "LS_SOLID",
        LS_DOUBLE: "LS_DOUBLE",
        LS_DASHED: "LS_DASHED",
        LS_DOTTED: "LS_DOTTED",
        LS_OTHER: "LS_OTHER"
    }
    return switcher.get(style, 'UNKNOWN_'.format(style))


class Cell:
    def __init__(self, top, left, bottom, right, type, cell_color, l_color, t_color, r_color, b_color,
                 l_style, t_style, r_style, b_style, l_width, t_width, r_width, b_width):
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.type = type
        self.cell_color = cell_color
        self.l_color = l_color
        self.t_color = t_color
        self.r_color = r_color
        self.b_color = b_color
        self.l_style = l_style
        self.t_style = t_style
        self.r_style = r_style
        self.b_style = b_style
        self.l_width = l_width
        self.t_width = t_width
        self.r_width = r_width
        self.b_width = b_width

    def __repr__(self):
        return pformat(vars(self))


cdef build_cell(CELL_INFO cell):
    return Cell(cell.rect.top, cell.rect.left, cell.rect.bottom, cell.rect.right,
                zone_type(cell.type), cell.cellcolor, cell.lcolor, cell.tcolor, cell.rcolor, cell.bcolor,
                line_style(cell.lstyle), line_style(cell.tstyle), line_style(cell.rstyle), line_style(cell.bstyle),
                cell.lwidth, cell.twidth, cell.rwidth, cell.bwidth)


class Zone:
    def __init__(self, top, left, bottom, right, type, cells):
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.type = type
        self.cells = cells

    def __repr__(self):
        return pformat(vars(self))


cdef build_zone(ZONE zone, cells):
    return Zone(zone.rectBBox.top, zone.rectBBox.left, zone.rectBBox.bottom, zone.rectBBox.right,
                zone_type(zone.type), cells)


class PreprocInfo:
    def __init__(self, rotation, slope, matrix, flags):
        self.rotation = rotation
        self.slope = slope
        self.matrix = matrix
        self.flags = flags

    def __repr__(self):
        return pformat(vars(self))


class ImageInfo:
    def __init__(self, size, dpi, mode):
        self.size = size
        self.dpi = dpi
        self.mode = mode

    def __repr__(self):
        return pformat(vars(self))

@contextmanager
def _timing(timings, name):
    started = datetime.now()
    try:
        yield
    finally:
        duration = datetime.now() - started
        timings[name] = duration.total_seconds()

cdef class Page:
    cdef CSDK sdk
    cdef HPAGE handle
    cdef public:
        object page_id
        object zones
        object letters

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
        self.close()

    @property
    def camera_image(self):
        cdef INTBOOL flag;
        with nogil:
            rc = kRecGetImgFlags(self.handle, IMG_FLAGS_CAMERAIMAGE, &flag)
        CSDK.check_err(rc, 'kRecGetImgFlags')
        return True if flag != 0 else False

    @camera_image.setter
    def camera_image(self, value):
        cdef INTBOOL flag = value;
        with nogil:
            rc = kRecSetImgFlags(self.handle, IMG_FLAGS_CAMERAIMAGE, flag)
        CSDK.check_err(rc, 'kRecSetImgFlags')

    def pre_process(self, timings = dict()):
        cdef RECERR rc
        with _timing(timings, 'ocr_preprocess_image'):
            with nogil:
                rc = kRecPreprocessImg(self.sdk.sid, self.handle)
            CSDK.check_err(rc, 'kRecPreprocessImg')

    def rotate(self, rotation, timings=dict()):
        cdef RECERR rc
        cdef IMG_ROTATE img_rotate
        with _timing(timings, 'ocr_rotate_image'):
            img_rotate = rotation
            with nogil:
                rc = kRecRotateImg(self.sdk.sid, self.handle, img_rotate)
            CSDK.check_err(rc, 'kRecRotateImg')

    def despeckle(self, despeckle_method, despeckle_level=None, timings=dict()):
        cdef RECERR rc
        cdef DESPECKLE_METHOD method
        cdef int level
        with _timing(timings, 'ocr_despeckle_image'):
            method = despeckle_method
            level = despeckle_level if despeckle_level else 0
            with nogil:
                rc = kRecForceDespeckleImg(self.sdk.sid, self.handle, NULL, method, level)
            # despeckle fails if current image is not black and white: ignore IMG_BITSPERPIXEL_ERR
            if rc != 0x8004C708:
                CSDK.check_err(rc, 'kRecForceDespeckleImg')

    @property
    def preproc_info(self):
        cdef RECERR rc
        cdef PREPROC_INFO preproc_info;
        with nogil:
            rc = kRecGetPreprocessInfo(self.handle, &preproc_info)
        CSDK.check_err(rc, 'kRecGetPreprocessInfo')
        matrix = list()
        for i in range(0, 8):
            matrix.append(PyFloat_FromDouble(preproc_info.Matrix[i]))
        flags = set()
        if preproc_info.Flags & PREPROC_INFO_FAXCORRECTION:
            flags.add('PREPROC_INFO_FAXCORRECTION')
        if preproc_info.Flags & PREPROC_INFO_INVERSION:
            flags.add('PREPROC_INFO_INVERSION')
        if preproc_info.Flags & PREPROC_INFO_3DDESKEW:
            flags.add('PREPROC_INFO_3DDESKEW')
        if preproc_info.Flags & PREPROC_INFO_STRAIGHTENED:
            flags.add('PREPROC_INFO_STRAIGHTENED')
        if preproc_info.Flags & PREPROC_INFO_HALFTONE:
            flags.add('PREPROC_INFO_HALFTONE')
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
        rot = preproc_info.Rotation
        return PreprocInfo(switcher.get(rot, 'UNKNOWN_{}'.format(rot)), preproc_info.Slope, matrix, flags)

    def locate_zones(self, timings=dict()):
        cdef RECERR rc
        with _timing(timings, 'ocr_locate_zones'):
            with nogil:
                rc = kRecLocateZones(self.sdk.sid, self.handle)
            CSDK.check_err(rc, 'kRecLocateZones')

    def remove_rule_lines(self, timings=dict()):
        cdef RECERR rc
        with _timing(timings, 'ocr_remove_rule_lines'):
            with nogil:
                rc = kRecRemoveLines(self.sdk.sid, self.handle, II_BW, NULL)
            CSDK.check_err(rc, 'kRecRemoveLines')

    def recognize(self, timings=dict()):
        cdef RECERR rc
        with _timing(timings, 'ocr_recognize'):
            with nogil:
                rc = kRecRecognize(self.sdk.sid, self.handle, NULL)
            CSDK.check_err(rc, 'kRecRecognize')
            
    def searchablePDF(self, timings=dict()):
        cdef RECERR rc
        with _timing(timings, 'ocr_searchablePDF'):
            with nogil:
                rc = kRecMakePagesSearchable(self.sdk.sid, pFilePath, i, &hPage, 1, II_CURRENT)
            CSDK.check_err(rc, 'kRecRecognize')

        # retrieve OCR zones
        cdef int nb_zones
        cdef int nb_cells
        cdef ZONE zone
        cdef CELL_INFO cell
        with _timing(timings, 'ocr_get_zones'):
            with nogil:
                rc = kRecCopyOCRZones(self.handle)
            CSDK.check_err(rc, 'kRecCopyOCRZones')
            with nogil:
                rc = kRecGetZoneCount(self.handle, &nb_zones)
            CSDK.check_err(rc, 'kRecGetZoneCount')
            self.zones = []
            for zone_id in range(nb_zones):
                with nogil:
                    rc = kRecGetZoneInfo(self.handle, II_CURRENT, &zone, zone_id)
                CSDK.check_err(rc, 'kRecGetZoneInfo')
                cells = []
                with nogil:
                    rc = kRecGetCellCount(self.handle, zone_id, &nb_cells)
                CSDK.check_err(rc, 'kRecGetCellCount')
                for cell_id in range(nb_cells):
                    with nogil:
                        rc = kRecGetCellInfo(self.handle, II_CURRENT, zone_id, cell_id, &cell)
                    CSDK.check_err(rc, 'kRecGetCellInfo')
                    cells.append(build_cell(cell))
                self.zones.append(build_zone(zone, cells))

        # retrieve letter choices
        cdef LPWCH pChoices
        cdef LONG nbChoices
        with nogil:
            rc = kRecGetChoiceStr(self.handle, &pChoices, &nbChoices)
        CSDK.check_err(rc, 'kRecGetChoiceStr')

        # retrieve letter suggestions
        cdef LPWCH pSuggestions
        cdef LONG nbSuggestions
        with nogil:
            rc = kRecGetSuggestionStr(self.handle, &pSuggestions, &nbSuggestions)
        CSDK.check_err(rc, 'kRecGetSuggestionStr')

        # retrieve letters
        cdef LPLETTER pLetters
        cdef LONG nb_letters
        cdef IMG_INFO img_info
        with _timing(timings, 'ocr_get_letters'):
            # we need vertical DPI to build letter font size
            with nogil:
                rc = kRecGetImgInfo(self.sdk.sid, self.handle, II_CURRENT, &img_info)
            CSDK.check_err(rc, 'kRecGetImgInfo')
            dpi_y = img_info.DPI.cy
            with nogil:
                rc = kRecGetLetters(self.handle, II_CURRENT, &pLetters, &nb_letters)
            CSDK.check_err(rc, 'kRecGetLetters')
            self.letters = []
            for letter_id in range(nb_letters):
                letter = build_letter(pLetters[letter_id], pChoices, pSuggestions, dpi_y)
                if letter and letter.zone_id < len(self.zones):
                    self.letters.append(letter)

        # cleanup
        with nogil:
            rc = kRecFree(pLetters)
        CSDK.check_err(rc, 'kRecFree')
        with nogil:
            rc = kRecFree(pChoices)
        CSDK.check_err(rc, 'kRecFree')
        with nogil:
            rc = kRecFree(pSuggestions)
        CSDK.check_err(rc, 'kRecFree')

    def get_image(self, image_index):
        cdef RECERR rc
        cdef IMG_INFO img_info
        cdef LPBYTE bitmap
        cdef PyObject *o
        cdef BYTE[768] palette
        cdef IMAGEINDEX img_index = image_index
        with nogil:
            rc = kRecGetImgArea(self.sdk.sid, self.handle, img_index, NULL, NULL, &img_info, &bitmap)
        CSDK.check_err(rc, 'kRecGetImgArea')
        o = PyBytes_FromStringAndSize(<const char*> bitmap, img_info.BytesPerLine * img_info.Size.cy)
        bytes = <object> o
        with nogil:
            rc = kRecFree(bitmap)
        CSDK.check_err(rc, 'kRecFree')
        if img_info.IsPalette == 1:
            CSDK.check_err(kRecGetImgPalette(self.sdk.sid, self.handle, image_index, palette), 'kRecGetImgPalette')
        if img_info.BitsPerPixel == 1:
            image = Image.frombytes('1', (img_info.BytesPerLine * 8, img_info.Size.cy), bytes, 'raw', '1;I', 0, 1)
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 0:
            image = Image.frombytes('L', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'L', img_info.BytesPerLine, 1)
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 1:
            image = Image.frombytes('P', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'P', img_info.BytesPerLine, 1)
            o = PyBytes_FromStringAndSize(<const char*> palette, sizeof(palette))
            palette_bytes = <object> o
            image.putpalette(palette_bytes)
        elif img_info.BitsPerPixel == 24:
            image = Image.frombytes('RGB', (img_info.Size.cx, img_info.Size.cy), bytes, 'raw', 'RGB', img_info.BytesPerLine, 1)
        else:
            raise CSDKException('OmniPage: unsupported number of bits per pixel: {}'.format(img_info.BitsPerPixel))
        return image

    def get_image_info(self, image_index):
        cdef RECERR rc
        cdef IMG_INFO img_info
        cdef IMAGEINDEX index = image_index
        with nogil:
            rc = kRecGetImgInfo(self.sdk.sid, self.handle, index, &img_info)
        CSDK.check_err(rc, 'kRecGetImgInfo')
        size = (img_info.Size.cx, img_info.Size.cy)
        dpi = (img_info.DPI.cx, img_info.DPI.cy)
        if img_info.BitsPerPixel == 1:
            mode = '1'
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 0:
            mode = 'L'
        elif img_info.BitsPerPixel == 8 and img_info.IsPalette == 1:
            mode = 'P'
        elif img_info.BitsPerPixel == 24:
            mode = 'RGB'
        else:
            mode = 'UNKNOWN(bits={}, palette={})'.format(img_info.BitsPerPixel, img_info.IsPalette)
        return ImageInfo(size, dpi, mode)

    def get_languages(self):
        cdef LANG_ENA languages[LANG_SIZE + 1]
        cdef RECERR rc
        with nogil:
            rc = kRecGetPageLanguages(self.handle, languages)
        CSDK.check_err(rc, 'kRecGetPageLanguages')
        cdef LANGUAGES lang
        result = set()
        for lang_code in range(int(LANG_SIZE)):
            if languages[lang_code] == LANG_ENABLED:
                lang = lang_code
                result.add(lang)
        return result
