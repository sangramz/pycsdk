ctypedef unsigned int RECERR
ctypedef const char* LPCSTR
ctypedef const char* LPCTSTR
ctypedef char* LPTSTR
ctypedef unsigned short* LPWSTR
ctypedef const unsigned short* LPCWSTR
ctypedef unsigned char BYTE
ctypedef unsigned char* LPBYTE
ctypedef unsigned short WCHAR
ctypedef unsigned short* LPWCH
ctypedef unsigned short WORD
ctypedef unsigned short* LPWORD
ctypedef unsigned int DWORD
ctypedef unsigned int* LPDWORD
ctypedef int INTBOOL
ctypedef int* LPINTBOOL
ctypedef int LONG
ctypedef int* LPLONG
ctypedef unsigned int UINT

cpdef enum KRECMODULES:
    INFO_API = 0
    INFO_MOR
    INFO_DOT
    INFO_BAR
    INFO_OMR
    INFO_HNR
    INFO_DCM
    INFO_IMG
    INFO_IMF
    INFO_CHR
    INFO_DTXT
    INFO_SPL
    INFO_RSD
    INFO_RER
    INFO_MGR
    INFO_MTX
    INFO_MAT
    INFO_RESERVED_P
    INFO_PLUS2W
    INFO_FRX
    INFO_PLUS3W
    INFO_ASN
    INFO_XOCR
    INFO_LFR
    INFO_ASP
    INFO_SIZE 
cpdef enum PROCESSID:
    PID_IMGINPUT = 0
    PID_IMGSAVE
    PID_IMGPREPROCESS
    PID_DECOMPOSITION
    PID_RECOGNITION1
    PID_RECOGNITION2
    PID_RECOGNITION3
    PID_SPELLING
    PID_FORMATTING
    PID_WRITEFOUTDOC
    PID_CONVERTIMG
    PID_SCANNER_WARMUP 
cpdef enum RETCODEINFO:
    RET_OK = 0
    RET_WARNING
    RET_MEMORY_ERROR
    RET_FILE_ERROR
    RET_SCANNER_ERROR
    RET_IMAGE_ERROR
    RET_OCR_ERROR
    RET_TEXT_ERROR
    RET_OTHER_ERROR
    RET_UNKNOWN = -1
cpdef enum STSTYPES:
    STS_UNDEFINED
    STS_ENUM
    STS_INT
    STS_DOUBLE
    STS_BOOL
    STS_STRING
    STS_USTRING
    STS_ARRAY_INT
    STS_ARRAY_DOUBLE
    STS_ARRAY_ENUM
    STS_ARRAY_BOOL
    STS_SET
    STS_REF
cpdef enum IMG_COMPRESSION:
    COMPRESS_TIFHU = 0
    COMPRESS_TIFG31
    COMPRESS_TIFG32
    COMPRESS_TIFG4
    COMPRESS_JPEG
    COMPRESS_JPG2K
    COMPRESS_SIZE
cpdef enum IMG_CONVERSION:
    CNV_AUTO = 0
    CNV_SET
    CNV_NO
    CNV_GLOBAL
    CNV_GRAY
cpdef enum IMF_FORMAT:
    FF_TIFNO = 0
    FF_TIFPB
    FF_TIFHU
    FF_TIFG31
    FF_TIFG32
    FF_TIFG4
    FF_TIFLZW
    FF_PCX
    FF_DCX
    FF_SIM
    FF_BMP_NO
    FF_BMP_RLE8
    FF_BMP_RLE4
    FF_AWD
    FF_JPG_SUPERB
    FF_JPG_LOSSLESS = FF_JPG_SUPERB
    FF_JPG_GOOD
    FF_JPG_MIN
    FF_PDA
    FF_PNG
    FF_XIFF
    FF_GIF
    FF_MAX_LOSSLESS
    FF_MAX_GOOD
    FF_MAX_MIN
    FF_PGX
    FF_PDF_MIN
    FF_PDF_GOOD
    FF_PDF_SUPERB
    FF_PDF_LOSSLESS = FF_PDF_SUPERB
    FF_PDF_MRC_MIN
    FF_PDF_MRC_GOOD
    FF_PDF_MRC_SUPERB
    FF_PDF_MRC_LOSSLESS = FF_PDF_MRC_SUPERB
    FF_TIFJPGNEW
    FF_JPG2K_LOSSLESS
    FF_JPG2K_GOOD
    FF_JPG2K_MIN
    FF_JBIG2_LOSSLESS
    FF_JBIG2_LOSSY
    FF_XPS
    FF_WMP
    FF_JBIG
    FF_OPG
    FF_SIZE
cpdef enum IMF_IMAGEQUALITY:
    IMF_IMAGEQUALITY_MIN = 0
    IMF_IMAGEQUALITY_GOOD = 1
    IMF_IMAGEQUALITY_SUPERB = 2
cpdef enum IMF_MRCLEVEL:
    IMF_MRCLEVEL_NO = 0
    IMF_MRCLEVEL_MIN = 1
    IMF_MRCLEVEL_GOOD = 2
    IMF_MRCLEVEL_SUPERB = 3
cpdef enum COMPRESSION_TRADEOFF:
    COMPRESSION_ADVANCED
    COMPRESSION_FAST
cpdef enum IMF_PDFCOMPATIBILITY:
    IMF_PDF_FORCESIZE = 0
    IMF_PDF_FORCEQUALITY = 1
    IMF_PDF15 = 2
    IMF_PDF14 = 3
    IMF_PDF13 = 4
    IMF_PDF12 = 5
    IMF_PDF11 = 6
    IMF_PDF10 = 7
    IMF_PDFA = 8
    IMF_PDFA1B = IMF_PDFA
    IMF_PDF16 = 9
    IMF_PDF17 = 10
    IMF_PDFA2B = 11
    IMF_PDFA2U = 12
    IMF_PDFA1A = 13
    IMF_PDFA2A = 14
    IMF_PDFA3B = 15
    IMF_PDFA3U = 16
    IMF_PDFA3A = 17
cpdef enum IMF_PDFENCRYPTION:
    IMF_PDFSECURITY_NONE
    IMF_PDFSECURITY_STANDARD
    IMF_PDFSECURITY_ENHANCED
    IMF_PDFSECURITY_AES
    IMF_PDFSECURITY_AES256
    IMF_PDFSECURITY_AES256X
cpdef enum ENCRYPT_LEVEL:
    ENC_NOPAS = 0
    ENC_MUSTPAS = 1
    ENC_MASTER = 2
    ENC_USER = 4
    ENC_MUSTUSER = ENC_MUSTPAS | ENC_USER
    ENC_MUSTMASTER = ENC_MUSTPAS | ENC_MASTER
    ENC_MUSTANY = ENC_MUSTPAS | ENC_MASTER | ENC_USER
    ENC_NOACCESS = 8
cpdef enum IMAGEINDEX:
    II_UNDEFINED = -1
    II_BGLAYER
    II_ORIGINAL
    II_CURRENT
    II_BW
    II_OCR
    II_THUMBNAIL
    II_OUTPUT
    II_SIZE
cpdef enum JPG_RESOLUTION:
    JPG_RES_USEDEFAULTDPI = 0
    JPG_RES_USEEXIF
cpdef enum IMG_ROTATE:
    ROT_AUTO = 0
    ROT_NO
    ROT_RIGHT
    ROT_DOWN
    ROT_LEFT
    ROT_FLIPPED = ROT_NO + 0x80
    ROT_RIGHT_FLIPPED
    ROT_DOWN_FLIPPED
    ROT_LEFT_FLIPPED
cpdef enum IMG_LINEORDER:
    TOP_DOWN = 0
    BOTTOM_UP
cpdef enum IMG_PADDING:
    PAD_BYTEBOUNDARY = 1
    PAD_WORDBOUNDARY = 2
    PAD_DWORDBOUNDARY = 4
cpdef enum IMG_RGBORDER:
    COLOR_RGB = 0
    COLOR_BGR
    COLOR_BGRA
    COLOR_ARGB
cpdef enum IMG_RESENH:
    RE_NO
    RE_YES
    RE_LEGACY
    RE_STANDARD
    RE_AUTO
cpdef enum IMG_INVERT:
    INV_NO = 0
    INV_YES
    INV_AUTO
cpdef enum IMG_DESKEW:
    DSK_2D = 0
    DSK_AUTO = DSK_2D
    DSK_NO
    DSK_SET
    DSK_3D
    DSK_AUTO3D
cpdef enum IMG_STRETCHMODE:
    STRETCH_DELETE = 0
    STRETCH_OR
    STRETCH_AND
    STRETCH_AVG
cpdef enum PREPROC_INFO_FLAGS:
    PREPROC_INFO_FAXCORRECTION = 1
    PREPROC_INFO_INVERSION = 2
    PREPROC_INFO_3DDESKEW = 4
    PREPROC_INFO_STRAIGHTENED = 8
    PREPROC_INFO_HALFTONE = 16
cpdef enum PROCESSING_MODE:
    PROCESSING_NORMAL = 0
    PROCESSING_BOOK = 1
cpdef enum FILLAREA_FLAGS:
    FILL_INSIDE = 0
    FILL_OUTSIDE = 1
    FILL_FLEXIBLEBPS = 2
cpdef enum DESPECKLE_METHOD:
    DESPECKLE_AUTO = 0
    DESPECKLE_NORMAL
    DESPECKLE_INVERSE
    DESPECKLE_HALFTONE
    DESPECKLE_MEDIAN
    DESPECKLE_PEPPER = 8
    DESPECKLE_SALT = 16
    DESPECKLE_PEPPERANDSALT =(DESPECKLE_PEPPER | DESPECKLE_SALT)
cpdef enum ERO_DIL_TYPE:
    ERO_DIL_3 = 0
    ERO_DIL_4
    ERO_DIL_8
cpdef enum IMG_FLAGS:
    IMG_FLAGS_CAMERAIMAGE = 0
    IMG_FLAGS_NORESOLUTION
cpdef enum RETAINCOLOR:
    RETAINCOLOR_NO
    RETAINCOLOR_YES
    RETAINCOLOR_INVERTED 
cpdef enum RLTYPES:
    LT_UNDEFINED
    LT_RULE
    LT_UNDERLINE
    LT_LEADER
    LT_SPLITTER
    LT_FRAME
    LT_JUNK
cpdef enum BORDERINDEX:
    LEFT_BORDER = 1
    TOP_BORDER = 2
    RIGHT_BORDER = 3
    BOTTOM_BORDER = 4
cpdef enum RLSTYLE:
    LS_NO
    LS_SOLID
    LS_DOUBLE
    LS_DASHED
    LS_DOTTED
    LS_OTHER
cpdef enum ZONETYPE:
    WT_FLOW
    WT_TABLE
    WT_GRAPHIC
    WT_AUTO
    WT_IGNORE
    WT_FORM
    WT_VERTTEXT
    WT_LEFTTEXT
    WT_RIGHTTEXT
cpdef enum FILLINGMETHOD:
    FM_DEFAULT = 0
    FM_OMNIFONT
    FM_DRAFTDOT9
    FM_BARCODE
    FM_OMR
    FM_HANDPRINT
    FM_BRAILLE
    FM_DRAFTDOT24
    FM_OCRA
    FM_OCRB
    FM_MICR
    FM_BARCODE2D
    FM_DOTDIGIT
    FM_DASHDIGIT
    FM_RESERVED_2
    FM_CMC7
    FM_NO_OCR
    FM_SIZE
cpdef enum IMG_DECOMP:
    DCM_AUTO
    DCM_LEGACY
    DCM_STANDARD
    DCM_FAST
cpdef enum RECOGNITIONMODULE:
    RM_AUTO = 0
    RM_OMNIFONT_MTX
    RM_OMNIFONT_MOR
    RM_DOT
    RM_BAR
    RM_OMR
    RM_HNR
    RM_RER
    RM_BRA
    RM_MAT
    RM_BAR_AMP
    RM_OMNIFONT_PLUS2W
    RM_OMNIFONT_FRX
    RM_OMNIFONT_PLUS3W
    RM_ASIAN
    RM_RESERVED_M
    RM_RESERVED_A
    RM_SIZE
cpdef enum CHR_FILTER:
    FILTER_DEFAULT = 0
    FILTER_DIGIT = 1
    FILTER_UPPERCASE = 2
    FILTER_LOWERCASE = 4
    FILTER_PUNCTUATION = 8
    FILTER_MISCELLANEOUS = 16
    FILTER_PLUS = 32
    FILTER_USER_DICT = 64
    FILTER_ALL
    FILTER_ALPHA =(FILTER_UPPERCASE | FILTER_LOWERCASE)
    FILTER_NUMBERS =(FILTER_DIGIT | FILTER_PLUS)
    FILTER_SIZE = 128
cpdef enum ANCHORCONTENT:
    AC_TEXT
    AC_BITMAP
    AC_BARCODE
    AC_LINE
    AC_LETTERS
cpdef enum ANCHORTYPE:
    AT_POSITIONAL
    AT_SELECTOR
    AT_REFERENCE
    AT_CHECK
    AT_SIZE
cpdef enum ANCHORFLAG:
    AF_REGEXP
    AF_RECOGNIZE
    AF_REGEXPDIDNTMATCH
    AF_CHECKED
cpdef enum ANCHOR_REF_POINT:
    REF_AUTO
    REF_CENTRE
    REF_TOP_LEFT
    REF_TOP_RIGHT
    REF_BOTTOM_LEFT
    REF_BOTTOM_RIGHT
cpdef enum REF_ANCHOR_MODE:
    REF_ANCHOR_0
    REF_ANCHOR_1
    REF_ANCHOR_2
    REF_ANCHOR_4
cpdef enum COMB_SPLITTER_HEIGHT:
    HALF_HEIGHT
    FULL_HEIGHT
cpdef enum BAR_ENA:
    BAR_DISABLED = 0
    BAR_ENABLED
cpdef enum RMTRADEOFF:
    TO_ACCURATE
    TO_BALANCED
    TO_FAST
cpdef enum PDF_REC_MODE:
    PDF_RM_ALWAYSRECOGNIZE
    PDF_RM_MOSTLYGETTEXT
    PDF_RM_ALWAYSGETTEXT
cpdef enum PDF_PROC_MODE:
    PDF_PM_AUTO
    PDF_PM_NORMAL
    PDF_PM_GRAPHICS_ONLY
    PDF_PM_TEXT_ONLY
    PDF_PM_TEXT_ONLY_EXT
    PDF_PM_AS_IMAGE
cpdef enum LETTERSTRENGTH:
    LTS_FINAL
    LTS_STRONG
    LTS_MEDIUM
    LTS_WEAK
    LTS_SIZE
cpdef enum LANG_ENA:
    LANG_DISABLED = 0
    LANG_ENABLED
cpdef enum MANAGE_LANG:
    SET_LANG = 0
    ADD_LANG
    REMOVE_LANG
    INVERT_LANG
    IS_LANG_ENABLED
cpdef enum LANGUAGES:
    LANG_ALL = -1024
    LANG_ALL_LATIN = -1023
    LANG_ALL_ASIAN = -1022
    LANG_START = -3
    LANG_UD = -3
    LANG_AUTO = -2
    LANG_NO = -1
    LANG_ENG = 0
    LANG_GER
    LANG_FRE
    LANG_DUT
    LANG_NOR
    LANG_SWE
    LANG_FIN
    LANG_DAN
    LANG_ICE
    LANG_POR
    LANG_SPA
    LANG_CAT
    LANG_GAL
    LANG_ITA
    LANG_MAL
    LANG_GRE
    LANG_POL
    LANG_CZH
    LANG_SLK
    LANG_HUN
    LANG_SLN
    LANG_CRO
    LANG_ROM
    LANG_ALB
    LANG_TUR
    LANG_EST
    LANG_LAT
    LANG_LIT
    LANG_ESP
    LANG_SRL
    LANG_SRB
    LANG_MAC
    LANG_MOL
    LANG_BUL
    LANG_BEL
    LANG_UKR
    LANG_RUS
    LANG_CHE
    LANG_KAB
    LANG_AFR
    LANG_AYM
    LANG_BAS
    LANG_BEM
    LANG_BLA
    LANG_BRE
    LANG_BRA
    LANG_BUG
    LANG_CHA
    LANG_CHU
    LANG_COR
    LANG_CRW
    LANG_ESK
    LANG_FAR
    LANG_FIJ
    LANG_FRI
    LANG_FRU
    LANG_GLI
    LANG_GLS
    LANG_GAN
    LANG_GUA
    LANG_HAN
    LANG_HAW
    LANG_IDO
    LANG_IND
    LANG_INT
    LANG_KAS
    LANG_KAW
    LANG_KIK
    LANG_KON
    LANG_KPE
    LANG_KUR
    LANG_LTN
    LANG_LUB
    LANG_LUX
    LANG_MLG
    LANG_MLY
    LANG_MLN
    LANG_MAO
    LANG_MAY
    LANG_MIA
    LANG_MIN
    LANG_MOH
    LANG_NAH
    LANG_NYA
    LANG_OCC
    LANG_OJI
    LANG_PAP
    LANG_PID
    LANG_PRO
    LANG_QUE
    LANG_RHA
    LANG_ROY
    LANG_RUA
    LANG_RUN
    LANG_SAM
    LANG_SAR
    LANG_SHO
    LANG_SIO
    LANG_SMI
    LANG_SML
    LANG_SMN
    LANG_SMS
    LANG_SOM
    LANG_SOT
    LANG_SUN
    LANG_SWA
    LANG_SWZ
    LANG_TAG
    LANG_TAH
    LANG_TIN
    LANG_TON
    LANG_TUN
    LANG_VIS
    LANG_WEL
    LANG_WEN
    LANG_WOL
    LANG_XHO
    LANG_ZAP
    LANG_ZUL
    LANG_JPN
    LANG_CHS
    LANG_CHT
    LANG_KRN
    LANG_THA
    LANG_ARA
    LANG_HEB
    LANG_SIZE
cpdef enum CONTINENT:
    C_EUROPE = 0x0001
    C_ASIA = 0x0002
    C_AFRICA = 0x0004
    C_OCEANIA = 0x0008
    C_LAMERICA = 0x0010
    C_NAMERICA = 0x0020
    C_INTERNATIONAL = 0x0040
cpdef enum BASIC_LANGUAGE_CHARSET:
    B_OTH = 0
    B_BAS = 1
    B_LAT = 2
    B_GRE = 4
    B_CYR = 8
    B_ASN = 16
    B_RTL = 32
cpdef enum RM_FLAGS:
    MTX_FLAG  =(1 << RM_OMNIFONT_MTX)
    MOR_FLAG  =(1 << RM_OMNIFONT_MOR)
    DOT_FLAG  =(1 << RM_DOT)
    BAR_FLAG  =(1 << RM_BAR)
    OMR_FLAG  =(1 << RM_OMR)
    HNR_FLAG  =(1 << RM_HNR)
    RER_FLAG  =(1 << RM_RER)
    MAT_FLAG  =(1 << RM_MAT)
    #RESERVED_P_FLAG  =(1 << RM_RESERVED_P)
    PLUS_FLAG =(1 << RM_OMNIFONT_PLUS3W)
    ASN_FLAG =(1 << RM_ASIAN)
    M_____RM_FLAG =(MOR_FLAG | PLUS_FLAG | BAR_FLAG | OMR_FLAG | HNR_FLAG | MAT_FLAG )
    MRD___RM_FLAG =(M_____RM_FLAG | RER_FLAG | DOT_FLAG)
    M___B_RM_FLAG =(M_____RM_FLAG)
    MRDX__RM_FLAG =(MRD___RM_FLAG | MTX_FLAG)
    MRD_B_RM_FLAG =(MRD___RM_FLAG)
    MRDXB_RM_FLAG =(MRDX__RM_FLAG)
    ASIAN_RM_FLAG =(BAR_FLAG | OMR_FLAG | ASN_FLAG)
    RER___RM_FLAG =(BAR_FLAG | OMR_FLAG | RER_FLAG)
cpdef enum LANGUAGE_CODE:
    LANGCODE_ALL = 0
    LANGCODE_ENGLISH
    LANGCODE_INT_3
    LANGCODE_639_1
    LANGCODE_639_2B
    LANGCODE_639_3
    LANGCODE_WIN_3
cpdef enum OUTCODEPAGETYPE:
    CODEP_UNKNOWN = 0
    SPECIFIC
    ASCII_BASED
    ANSI_BASED
    MAC_BASED
    INTERNAL_CP
    ASIAN_CODEPAGE
cpdef enum DTXTOUTPUTFORMATS:
    DTXT_TXTS
    DTXT_TXTCSV
    DTXT_TXTF
    DTXT_PDFIOT
    DTXT_XMLCOORD
    DTXT_BINARY
    DTXT_IOTPDF
    DTXT_IOTPDF_MRC
cpdef enum HPAGESaveFlags:
    HPSF_Default = 0x0000
    HPSF_SaveAll = 0xFFFF
        
cdef extern from "KernelApi.h":

    # general operations module
    # -------------------------

    ctypedef struct KRECMODULEINFO:
        int Version
        RECERR InitError
    ctypedef struct PROGRESSMONITOR:
        PROCESSID ProcessId
        int Percent
        int Reserved
        const char * Filename
        int PageNumber
    ctypedef KRECMODULEINFO * LPKRECMODULEINFO
    ctypedef PROGRESSMONITOR * LPPROGRESSMONITOR
    ctypedef RECERR PROGMON_CB(LPPROGRESSMONITOR mod, void *pContext)
    ctypedef PROGMON_CB * LPPROGMON_CB
    RECERR kRecSetLicense(LPCTSTR pLicenseFile, LPCTSTR pCode)
    RECERR kRecInit(LPCTSTR pCompanyName, LPCTSTR pProductName)
    RECERR kRecQuit()
    RECERR kRecSetUILang(const char *lang)
    RECERR kRecGetUILang(char *langbuff, size_t buffersize)
    int kRecCreateSettingsCollection(int sid)
    RECERR kRecDeleteSettingsCollection(int sid)
    RECERR kRecGetSerialNumber(LPTSTR pSn, size_t buflen)
    int kRecGetVersion()
    RECERR kRecSetCBProgMon(int sid, LPPROGMON_CB pCallBack, void *pContext)
    RECERR kRecSetTimeOut(int sid, DWORD TimeOut)
    RECERR kRecGetTimeOut(int sid, LPDWORD pTimeOut)
    RECERR kRecFree(void *pArray) nogil
    RECERR kRecGetModulesInfo(LPKRECMODULEINFO *ppModules, size_t *pSize)
    RECERR kRecLoadSettings(int sid, LPCTSTR pFileName)
    RECERR kRecSaveSettings(int sid, LPCTSTR pFileName)
    RECERR kRecSetDefaults(int sid)

    # error handling module
    # ---------------------
    RECERR kRecGetLastError(LONG *pErrExt, LPTSTR pErrStr, int buflen)
    RECERR kRecGetLastErrorEx(LONG *pErrExt, LPTSTR *ppErrStr, LPTSTR *ppErrXml)
    RETCODEINFO kRecGetErrorInfo(RECERR ErrCode, LPCSTR *lpErrSym)
    RECERR kRecGetErrorUIText(RECERR ErrCode, LONG ErrExt, LPCTSTR lpErrStr, LPTSTR lpErrUIText, int *pBuffLen)

    # settings manager module
    # -----------------------
    ctypedef struct SEnumTypeElement:
        const char* id
        int value
    ctypedef struct RECSTSSTRUCT:
        pass
    ctypedef RECSTSSTRUCT* HSETTING
    RECERR kRecSettingGetHandle(HSETTING root_of_query, const char *symb_name, HSETTING *ret_handle, INTBOOL *has_setting)
    RECERR kRecSettingHasSetting(HSETTING node, INTBOOL *has_setting)
    RECERR kRecSettingGetType(HSETTING sett, STSTYPES *type)
    RECERR kRecSettingIsFlagSet(HSETTING sett, unsigned int flgs, INTBOOL *is_set)
    RECERR kRecSettingGetName(HSETTING node, const char **the_name)
    RECERR kRecSettingIsDefault(int sid, HSETTING node, INTBOOL *is_default)
    RECERR kRecSettingGetNextChild(HSETTING the_parent, HSETTING prev_child, HSETTING *the_child)
    RECERR kRecSettingGetCloneOrigin(HSETTING clone_node, HSETTING *origin_node)
    RECERR kRecSettingGetInt(int sid, HSETTING sett, int *the_value)
    RECERR kRecSettingGetDouble(int sid, HSETTING sett, double *the_value)
    RECERR kRecSettingGetString(int sid, HSETTING sett, const char **the_value)
    RECERR kRecSettingGetUString(int sid, HSETTING sett, const WCHAR **the_value)
    RECERR kRecSettingGetIntArray(int sid, HSETTING sett, const int **the_value)
    RECERR kRecSettingGetDoubleArray(int sid, HSETTING sett, const double **the_value)
    RECERR kRecSettingGetIntArrayAt(int sid, HSETTING sett, int index, int *the_value)
    RECERR kRecSettingGetDoubleArrayAt(int sid, HSETTING sett, int index, double *the_value)
    RECERR kRecSettingGetIntDefault(HSETTING sett, int *the_default)
    RECERR kRecSettingGetDoubleDefault(HSETTING sett, double *the_default)
    RECERR kRecSettingGetStringDefault(HSETTING sett, const char **the_default)
    RECERR kRecSettingGetUStringDefault(HSETTING sett, const WCHAR **the_default)
    RECERR kRecSettingGetIntArrayDefault(HSETTING sett, const int **the_default)
    RECERR kRecSettingGetDoubleArrayDefault(HSETTING sett, const double **the_default)
    RECERR kRecSettingGetSymbolic(int sid, HSETTING sett, char *the_value, unsigned int *buffer_size)
    RECERR kRecSettingGetIntArrayDefaultAt(HSETTING sett, int index, int *the_default)
    RECERR kRecSettingGetDoubleArrayDefaultAt(HSETTING sett, int index, double *the_default)
    RECERR kRecSettingGetNumberOfEnumElements(HSETTING sett, int *num_of_values)
    RECERR kRecSettingGetEnumElement(HSETTING sett, int index, const char **str_value, int *int_value)
    RECERR kRecSettingSetInt(int sid, HSETTING sett, int new_value)
    RECERR kRecSettingSetDouble(int sid, HSETTING sett, double new_value)
    RECERR kRecSettingSetString(int sid, HSETTING sett, const char *new_value)
    RECERR kRecSettingSetUString(int sid, HSETTING sett, const WCHAR *new_value)
    RECERR kRecSettingSetIntArray(int sid, HSETTING sett, const int *new_values)
    RECERR kRecSettingSetDoubleArray(int sid, HSETTING sett, const double *new_values)
    RECERR kRecSettingSetIntArrayAt(int sid, HSETTING sett, int index, int new_value)
    RECERR kRecSettingSetDoubleArrayAt(int sid, HSETTING sett, int index, double new_value)
    RECERR kRecSettingSetToDefault(int sid, HSETTING sett, INTBOOL whole_subtree)
    RECERR kRecSettingSetToDefaultPlusC(int sid, HSETTING sett, INTBOOL whole_subtree)
    RECERR kRecSettingSetArrayToDefaultAt(int sid, HSETTING sett, int index)
    RECERR kRecSettingSetArrayToDefaultAtPlusC(int sid, HSETTING sett, int index)
    RECERR kRecSettingGetSizeOfArray(HSETTING sett, int *the_size)
    RECERR kRecSettingCreateInt(HSETTING *created_setting, STSTYPES type, HSETTING root_of_creation, const char *symb_name, unsigned int flags, int def_value, const SEnumTypeElement *enum_elements)
    RECERR kRecSettingCreateDouble(HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, double def_value)
    RECERR kRecSettingCreateString(HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, const char *def_value)
    RECERR kRecSettingCreateUString(HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, const WCHAR *def_value)
    RECERR kRecSettingCreateIntArray(HSETTING *created_setting, STSTYPES type, HSETTING root_of_creation, const char *symb_name, int size, unsigned int flags, const int *def_values, const SEnumTypeElement *enum_elements)
    RECERR kRecSettingCreateDoubleArray(HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, int size, unsigned int flags, const double *def_values)
    RECERR kRecSettingDelete(HSETTING node)
    RECERR kRecSettingDeleteSubtree(HSETTING root_of_subtree)
    RECERR kRecSettingClone(HSETTING root_of_cloning, const char *new_symb_name)
    RECERR kRecSettingLoad(int sid, LPCTSTR filename)
    RECERR kRecSettingSave(int sid, HSETTING root_of_subtree, LPCTSTR filename, INTBOOL save_all, INTBOOL append)
    RECERR kRecSettingCopyValues(HSETTING node, int from_sid, int to_sid, INTBOOL whole_subtree)

    # image file handling module
    # --------------------------
    ctypedef struct tagIMGFILEHANDLE:
        pass
    ctypedef tagIMGFILEHANDLE* HIMGFILE
    ctypedef struct SIZE:
        int cx
        int cy
    ctypedef SIZE* LPSIZE
    ctypedef const SIZE* LPCSIZE
    ctypedef struct IMG_INFO:
        SIZE Size
        SIZE DPI
        unsigned int BytesPerLine
        INTBOOL IsPalette
        WORD BitsPerPixel
        void* DummyS
    ctypedef IMG_INFO* LPIMG_INFO
    ctypedef const IMG_INFO* LPCIMG_INFO
    ctypedef struct COMPRESSED_IMG_INFO:
        IMG_COMPRESSION Compression
        SIZE Size
        SIZE DPI
        WORD BitsPerPixel
        void * DummyS
    ctypedef COMPRESSED_IMG_INFO* LPCOMPRESSED_IMG_INFO
    ctypedef const COMPRESSED_IMG_INFO* LPCCOMPRESSED_IMG_INFO
    ctypedef struct RECPAGESTRUCT:
        pass
    ctypedef RECPAGESTRUCT* HPAGE
    ctypedef struct RECT:
        int left
        int top
        int right
        int bottom
    ctypedef RECT* LPRECT
    ctypedef const RECT* LPCRECT
    ctypedef IMG_CONVERSION* LPIMG_CONVERSION
    RECERR kRecOpenImgFile(LPCTSTR pFilename, HIMGFILE *pHIMGFILE, int mode, IMF_FORMAT filetype) nogil
    RECERR kRecCloseImgFile(HIMGFILE hIFile) nogil
    RECERR kRecGetPDFEncLevel(HIMGFILE hIFile, ENCRYPT_LEVEL *pEncLev)
    RECERR kRecSetImfLoadFlags(int sid, DWORD fFlag)
    RECERR kRecGetImfLoadFlags(int sid, DWORD *pfFlag)
    RECERR kRecLoadImg(int sid, HIMGFILE hIFile, HPAGE *phPage, int iPage) nogil
    RECERR kRecLoadImgF(int sid, LPCTSTR pFilename, HPAGE *phPage, int nPage)
    RECERR kRecLoadImgDataStream(int sid, HIMGFILE hIFile, HPAGE *phPage, int iPage)
    RECERR kRecLoadImgDataStreamF(int sid, LPCTSTR pFilename, HPAGE *phPage, int nPage)
    RECERR kRecDecompressImgDataStream(int sid, HPAGE hPage)
    RECERR kRecFreeImgDataStream(int sid, HPAGE hPage)
    RECERR kRecLoadImgM(int sid, BYTE *lpBitmap, LPCIMG_INFO lpImg, HPAGE *phPage)
    RECERR kRecLoadImgMC(int sid, BYTE *lpBuf, size_t bufLen, LPCCOMPRESSED_IMG_INFO lpCImg, HPAGE *phPage)
    RECERR kRecLoadImgDataStreamMC(int sid, BYTE *lpBuf, size_t bufLen, LPCOMPRESSED_IMG_INFO lpCImg, HPAGE *phPage)
    RECERR kRecSetCompressionLevel(int sid, int CompressionLevel)
    RECERR kRecGetCompressionLevel(int sid, int *pCompressionLevel)
    RECERR kRecSetCompressionTradeoff(int sid, COMPRESSION_TRADEOFF CompressionTradeoff)
    RECERR kRecGetCompressionTradeoff(int sid, COMPRESSION_TRADEOFF *pCompressionTradeoff)
    RECERR kRecSetMRCCompressionSettingsFromLevel(int sid, int CompressionLevel, COMPRESSION_TRADEOFF CompressionTradeOff)
    RECERR kRecSetJPGQuality(int sid, int nQuality)
    RECERR kRecGetJPGQuality(int sid, int *pnQuality)
    RECERR kRecSaveImg(int sid, HIMGFILE hIFile, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgForce(int sid, HIMGFILE hIFile, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgF(int sid, LPCTSTR pFilename, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX img, INTBOOL bAppend)
    RECERR kRecSaveImgForceF(int sid, LPCTSTR pFilename, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgArea(int sid, HIMGFILE hIFile, IMF_FORMAT format, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, INTBOOL append)
    RECERR kRecSaveImgAreaF(int sid, LPCTSTR pFilename, IMF_FORMAT format, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, INTBOOL append)
    RECERR kRecSetPdfPassword(HIMGFILE hIFile, LPCTSTR pwd)
    RECERR kRecSetPdfTagInfo(int sid, INTBOOL bUseTagInfo)
    RECERR kRecGetPdfTagInfo(int sid, INTBOOL *pbUseTagInfo)
    RECERR kRecGetImgFilePageCount(HIMGFILE hIFile, int *lpPageCount) nogil
    RECERR kRecGetImgFilePageInfo(int sid, HIMGFILE hIFile, int nPage, LPIMG_INFO pImg, IMF_FORMAT *pFormat)
    RECERR kRecCopyImgFilePage(int sid, HIMGFILE hIFileDst, int ndstPage, HIMGFILE hIFileSrc, int nsrcPage)
    RECERR kRecDeleteImgFilePage(int sid, HIMGFILE hIFile, int nPage)
    RECERR kRecInsertImgFilePage(int sid, HPAGE hPage, IMAGEINDEX iiImg, HIMGFILE hIFile, int nPage, IMF_FORMAT format)
    RECERR kRecIsMultipageImgFileFormat(IMF_FORMAT imgfileformat, INTBOOL *bEnabled)
    RECERR kRecMatchImgFileFormat(int sid, HPAGE hPage, IMAGEINDEX iiImg, IMF_FORMAT imgfileformat, INTBOOL *match)
    RECERR kRecPackImgFile(int sid, LPCTSTR pFileName)
    RECERR kRecUpdateImgFilePage(int sid, HPAGE hPage, IMAGEINDEX iiImg, HIMGFILE hIFile, int nPage, IMF_FORMAT format)
    RECERR kRecReplaceImgFilePage(int sid, HIMGFILE hIFileDst, int ndstPage, HIMGFILE hIFileSrc, int nsrcPage)
    RECERR kRecGetImgFilePageIndex(HIMGFILE hIFile, int *pIndex)
    
    # image handling module
    # ---------------------
    ctypedef DWORD REC_COLOR
    ctypedef struct PREPROC_INFO:
        IMG_ROTATE Rotation
        int Slope
        PREPROC_INFO_FLAGS Flags
        double Matrix [8]
    ctypedef struct CUT_INFO:
        int x
        int info
        int first_x
        int last_x
        int dpi
    ctypedef struct POINT:
        int x
        int y
    ctypedef POINT* LPPOINT
    ctypedef struct RLINE:
        POINT start
        POINT end
        unsigned short width
        RLSTYLE style
        REC_COLOR color
        RLTYPES type
        unsigned short flag
        DWORD plist
    ctypedef RLINE* PRLINE
    ctypedef struct CELL_INFO:
        RECT rect
        ZONETYPE type
        REC_COLOR cellcolor
        REC_COLOR lcolor
        REC_COLOR tcolor
        REC_COLOR rcolor
        REC_COLOR bcolor
        RLSTYLE lstyle
        RLSTYLE tstyle
        RLSTYLE rstyle
        RLSTYLE bstyle
        BYTE lwidth
        BYTE twidth
        BYTE rwidth
        BYTE bwidth
        int ref
        UINT flags
    ctypedef CELL_INFO* LPCELL_INFO
    ctypedef const CELL_INFO* LPCCELL_INFO
    RECERR kRecSetImgDownsample(int sid, INTBOOL downsample)
    RECERR kRecGetImgDownsample(int sid, INTBOOL *pdownsample)
    RECERR kRecSetPreserveOriginalImg(int sid, INTBOOL preserve)
    RECERR kRecGetPreserveOriginalImg(int sid, INTBOOL *pPreserve)
    RECERR kRecSetFaxCorrection(int sid, INTBOOL corr)
    RECERR kRecGetFaxCorrection(int sid, INTBOOL *pCorr)
    RECERR kRecSetThumbnailImgInfo(int sid, const IMG_INFO *pThumbnail, REC_COLOR color)
    RECERR kRecGetThumbnailImgInfo(int sid, IMG_INFO *pThumbnail, REC_COLOR *pColor)
    RECERR kRecSetImgBinarizationMode(int sid, IMG_CONVERSION BWConversion)
    RECERR kRecGetImgBinarizationMode(int sid, LPIMG_CONVERSION pBWConversion)
    RECERR kRecSetImgBrightness(int sid, int Brightness)
    RECERR kRecGetImgBrightness(int sid, int *lpBrightness)
    RECERR kRecSetImgThreshold(int sid, int Threshold)
    RECERR kRecGetImgThreshold(int sid, int *pThreshold)
    RECERR kRecSetImgInvert(int sid, IMG_INVERT ImgInvert)
    RECERR kRecGetImgInvert(int sid, IMG_INVERT *lpImgInvert)
    RECERR kRecSetImgDeskew(int sid, IMG_DESKEW _ImgDeskew)
    RECERR kRecGetImgDeskew(int sid, IMG_DESKEW *pImgDeskew)
    RECERR kRecSetImgSlope(int sid, int Slope)
    RECERR kRecGetImgSlope(int sid, int *lpSlope)
    RECERR kRecSetImgRotation(int sid, IMG_ROTATE imgRotate)
    RECERR kRecGetImgRotation(int sid, IMG_ROTATE *lpImgRotate)
    RECERR kRecSetImgFormat(int sid, IMG_LINEORDER lineord, IMG_PADDING padding, IMG_RGBORDER ord)
    RECERR kRecGetImgFormat(int sid, IMG_LINEORDER *plineord, IMG_PADDING *ppadding, IMG_RGBORDER *pord)
    RECERR kRecSetImgStretchMode(int sid, IMG_STRETCHMODE ImgStretchMode)
    RECERR kRecGetImgStretchMode(int sid, IMG_STRETCHMODE *pImgStretchMode)
    RECERR kRecSetImgResolEnhancement(int sid, IMG_RESENH res)
    RECERR kRecGetImgResolEnhancement(int sid, IMG_RESENH *res)
    RECERR kRecSetImgDespeckleMode(int sid, INTBOOL bMode)
    RECERR kRecGetImgDespeckleMode(int sid, LPINTBOOL lpbMode)
    RECERR kRecSetImgConvMode(int sid, IMG_CONVERSION Conversion)
    RECERR kRecGetImgConvMode(int sid, IMG_CONVERSION *pConversion)
    RECERR kRecPreprocessImg(int sid, HPAGE hPage) nogil
    RECERR kRecGetPreprocessInfo(HPAGE hPage, PREPROC_INFO *pPreprocInfo) nogil
    RECERR kRecRemovePunchHoles(int sid, HPAGE hPage, LPCRECT ROIs, int nROIs, LPRECT *Holes, int *nHoles, UINT flags, UINT minDiameter, UINT maxDiameter)
    RECERR kRecRemoveBorders(int sid, HPAGE hPage, UINT maxWidth)
    RECERR kRecDetectBook(int sid, HPAGE hPage, CUT_INFO *pInfo)
    RECERR kRecCreateBookPages(int sid, HPAGE hPage, HPAGE *phPage1, HPAGE *phPage2, const CUT_INFO *pInfo)
    RECERR kRecResetBookSize(int sid)
    RECERR kRecDetectBlankPage(int sid, HPAGE hPage, INTBOOL *pIsBlank)
    RECERR kRecAutoCropImg(int sid, HPAGE hPage, int lrMargin, int tbMargin, UINT flags)
    RECERR kRecDetectFillingMethod(int sid, HPAGE hPage, FILLINGMETHOD *pocrType)
    RECERR kRecDetectImgSkew(int sid, HPAGE hPage, int *pSlope, IMG_ROTATE *pImgRotate)
    RECERR kRecPutImgArea(int sid, LPCIMG_INFO lpImg, const BYTE *lpBitmap, HPAGE hPage, int xDst, int yDst, LPCSIZE pDstSize)
    RECERR kRecGetImgArea(int sid, HPAGE hPageIn, IMAGEINDEX iiImg, LPCRECT pSrcRect, LPCSIZE pDstSize, LPIMG_INFO pImg, BYTE **ppBitmap) nogil
    RECERR kRecGetImgAreaEx(int sid, HPAGE hPageIn, IMAGEINDEX iiImg, LPCRECT pSrcRect, LPCSIZE pDstSize, IMG_STRETCHMODE StretchMode, IMG_LINEORDER LineOrder, IMG_RGBORDER RGBOrder, INTBOOL strict, IMG_PADDING Padding, LPIMG_INFO pImg, BYTE **ppBitmap)
    RECERR kRecStartReadImg(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, IMG_ROTATE ImgRotation, LPWORD pBytes)
    RECERR kRecReadImg(int sid, LPBYTE pBuff)
    RECERR kRecStopReadImg(int sid)
    RECERR kRecStartWriteImg(int sid, LPCIMG_INFO pImg)
    RECERR kRecWriteImg(int sid, const LPBYTE pBuff)
    RECERR kRecStopWriteImg(int sid, HPAGE *phPage)
    RECERR kRecRotateImgArea(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pSrcRect, IMG_ROTATE Rotation, LPIMG_INFO lpImg, BYTE **lplpBitmap)
    RECERR kRecInvertImgArea(int sid, HPAGE hPage, LPCRECT lpRect)
    RECERR kRecClearImgArea(int sid, HPAGE hPage, LPCRECT lpRect)
    RECERR kRecFillImgArea(int sid, HPAGE hPage, LPCRECT lpRect, REC_COLOR color, FILLAREA_FLAGS flags)
    RECERR kRecDeskewImg(int sid, HPAGE hPage, int ImgSlope)
    RECERR kRec3DDeskewImg(int sid, HPAGE hPage)
    RECERR kRecEnhanceWhiteboardImg(HPAGE hPage)
    RECERR kRecTransformImgByMatrix(int sid, HPAGE hPage, const SIZE *newsize, const double *matrix)
    RECERR kRecTransformImgByPoints(int sid, HPAGE hPage, const SIZE *newsize, const POINT *pOriginal, const POINT *pTransformed, int nPoints)
    RECERR kRecIsImgPalette(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPINTBOOL pbPal)
    RECERR kRecSetImgPalette(HPAGE hPage, const BYTE *pPal)
    RECERR kRecGetImgPalette(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPBYTE pPal)
    RECERR kRecDespeckleImg(int sid, HPAGE hPage)
    RECERR kRecForceDespeckleImg(int sid, HPAGE hPage, LPCRECT pRect, DESPECKLE_METHOD method, int level)
    RECERR kRecImgErosion(int sid, HPAGE hPage, ERO_DIL_TYPE type)
    RECERR kRecImgDilatation(int sid, HPAGE hPage, ERO_DIL_TYPE type)
    RECERR kRecConvertImg2BW(int sid, HPAGE hPageIn, IMG_CONVERSION Conversion, int Brightness, int Threshold, IMG_RESENH resolenh, HPAGE *phPageOut)
    RECERR kRecTransformImg(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pSrcRect, LPCSIZE pDstSize, WORD BitsPerPixel, HPAGE *phPageOut)
    RECERR kRecTransformImgPalette(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pSrcRect, LPCSIZE pDstSize, HPAGE *phPageOut)
    RECERR kRecCopyImgArea(int sid, HPAGE hPageDst, LPCRECT pRectDst, HPAGE hPageSrc, LPCRECT pRectSrc)
    RECERR kRecMergeImgArea(int sid, HPAGE hPageDst, LPCRECT pRectDst, HPAGE hPageSrc, LPCRECT pRectSrc, REC_COLOR tColor)
    RECERR kRecConvertImg(int sid, HPAGE hPage, WORD BitsPerPixel, UINT flags)
    RECERR kRecLineRemoval(int sid, HPAGE hPage, const RECT *pRect)
    RECERR kRecRemoveLines(int sid, HPAGE hPage, IMAGEINDEX iiImg, const RECT *pRect)
    RECERR kRecGetLineCount(HPAGE hPage, int *pnLines)
    RECERR kRecGetLineInfo(HPAGE hPage, IMAGEINDEX iiImg, PRLINE pLine, int nLine)
    RECERR kRecGetFrameCount(HPAGE hPage, int *pnFrames)
    RECERR kRecGetFrameInfo(HPAGE hPage, IMAGEINDEX iiImg, LPCELL_INFO pFrame, int nFrame)
    RECERR kRecSetDropoutColorWeights(int sid, int wred, int wgreen, int wblue)
    RECERR kRecGetDropoutColorWeights(int sid, int *pwred, int *pwgreen, int *pwblue)
    RECERR kRecDetectDropoutColorWeights(int sid, HPAGE hPage, IMAGEINDEX iiImg, RECT *pRect, int *pwred, int *pwgreen, int *pwblue)
    RECERR kRecDropImg(HPAGE hPage, IMAGEINDEX iiImg)
    RECERR kRecTransformCoordinates(HPAGE hPage, IMAGEINDEX iiDst, IMAGEINDEX iiSrc, int nP, LPPOINT pPoint)
    RECERR kRecRotateImg(int sid, HPAGE hPage, IMG_ROTATE Rotation)
    RECERR kRecCreateImg(int sid, int sizeX, int sizeY, int dpiX, int dpiY, WORD BitsPerPixel, HPAGE *phPage)
    RECERR kRecFreeImg(HPAGE hPage) nogil
    RECERR kRecGetImgInfo(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPIMG_INFO pImg)
    RECERR kRecGetImgMetaData(HPAGE hPage, HSETTING *phMetaData)
    RECERR kRecGetImgFlags(HPAGE hPage, IMG_FLAGS Flag, INTBOOL *pbValue)
    RECERR kRecSetImgFlags(HPAGE hPage, IMG_FLAGS Flag, INTBOOL bValue)
    RECERR kRecSetImgResolution(HPAGE hPage, SIZE DPI)
    RECERR kRecSetRetainColor(int sid, RETAINCOLOR RetainColor)
    RECERR kRecGetRetainColor(int sid, RETAINCOLOR *pRetainColor)
    RECERR kRecImgAutoEnhance(HPAGE hPage, BYTE blackPointred, BYTE whitePointred, BYTE blackPointgreen, BYTE whitePointgreen, BYTE blackPointblue, BYTE whitePointblue)

    # zone handling module
    # --------------------
    RECERR kRecLocateTable(int sid, HPAGE hPage, int zone, INTBOOL bForce)
    RECERR kRecCreateTableInfo(HPAGE hPage, int xZone)
    RECERR kRecGetCellCount(HPAGE hPage, int xZone, int *pnCells) nogil
    RECERR kRecGetCellInfo(HPAGE hPage, IMAGEINDEX iiImg, int xZone, int CellIndex, LPCELL_INFO pCellInfo) nogil
    RECERR kRecSplitCells(HPAGE hPage, IMAGEINDEX iiImg, int xZone, INTBOOL bVertical, const RECT *pRect, POINT Position, int LineWidth, int LineStyle, REC_COLOR lineColor)
    RECERR kRecMergeCells(HPAGE hPage, IMAGEINDEX iiImg, int xZone, const RECT *pRect)
    RECERR kRecGetPointInfoFromTable(HPAGE hPage, IMAGEINDEX iiImg, int xZone, POINT Point, int xDist, int yDist, int *pCellIndex, BORDERINDEX *pBorderIndex)
    RECERR kRecMoveCellBorder(HPAGE hPage, IMAGEINDEX iiImg, int xZone, int CellIndex, BORDERINDEX BorderIndex, POINT NewPosition)
#    RECERR kRecDragCellBorder(HPAGE hPage, IMAGEINDEX iiImg, int xZone, int CellIndex, BORDERINDEX BorderIndex, POINT *xy, POINT *from, POINT *to, POINT *mmin, POINT *mmax)
    RECERR kRecGetTabPositionInTable(HPAGE hPage, IMAGEINDEX iiImg, int xZone, POINT Point, POINT *pTab)
    RECERR kRecSetCells(HPAGE hPage, IMAGEINDEX iiImg, int xZone, LPCCELL_INFO pCells, int nCells)
    RECERR kRecSetCellColor(HPAGE hPage, int xZone, int CellIndex, REC_COLOR color)
    RECERR kRecGetCellColor(HPAGE hPage, int xZone, int CellIndex, REC_COLOR *pcolor)
    RECERR kRecGetHSplitters(HPAGE hPage, IMAGEINDEX iiImg, int xZone, int **pSplitters, int *nSplitter)
    RECERR kRecGetVSplitters(HPAGE hPage, IMAGEINDEX iiImg, int xZone, int **pSplitters, int *nSplitter)
    ctypedef struct ZONE:
        RECT rectBBox
        ZONETYPE type
        DWORD userdata
        DWORD chk_control
        FILLINGMETHOD fm
        RECOGNITIONMODULE rm
        CHR_FILTER filter
        DWORD chk_fn
        char chk_sect [16]
    ctypedef ZONE* LPZONE
    ctypedef const ZONE* LPCZONE
    ctypedef struct ZONEDATA:
        REC_COLOR color
    ctypedef ZONEDATA* LPZONEDATA
    RECERR kRecSetDecompMethod(int sid, IMG_DECOMP Algorithm)
    RECERR kRecGetDecompMethod(int sid, IMG_DECOMP *pAlgorithm)
    RECERR kRecSetNongriddedTableDetect(int sid, INTBOOL bEnable)
    RECERR kRecGetNongriddedTableDetect(int sid, INTBOOL *bEnable)
    RECERR kRecSetForceSingleColumn(int sid, INTBOOL bForceSingle)
    RECERR kRecGetForceSingleColumn(int sid, INTBOOL *pbForceSingle)
    RECERR kRecLocateZones(int sid, HPAGE hPage)
    RECERR kRecSetPageDescription(int sid, DWORD PageDesc)
    RECERR kRecGetPageDescription(int sid, DWORD *pPageDesc)
    RECERR kRecGetZoneCount(HPAGE hPage, int *pnZones) nogil
    RECERR kRecGetZoneInfo(HPAGE hPage, IMAGEINDEX iiImg, LPZONE pZone, int nZone) nogil
    RECERR kRecGetZoneLayout(HPAGE hPage, IMAGEINDEX iiImg, LPRECT *ppRects, int *pnRects, int iZone)
    RECERR kRecGetZoneNodeArray(HPAGE hPage, IMAGEINDEX iiImg, LPPOINT *ppPoints, int *pnNodes, int iZone)
    RECERR kRecDeleteAllZones(HPAGE hPage)
    RECERR kRecDeleteZone(HPAGE hPage, int nZone)
    void kRecInitZone(LPZONE pZone)
    RECERR kRecInsertZone(HPAGE hPage, IMAGEINDEX iiImg, LPCZONE pZone, int nZone)
    RECERR kRecAddZoneRect(HPAGE hPage, IMAGEINDEX iiImg, const RECT *pRect, int nZone)
    RECERR kRecSubZoneRect(HPAGE hPage, IMAGEINDEX iiImg, const RECT *pRect, int nZone)
    RECERR kRecCopyOCRZones(HPAGE hPage) nogil
    RECERR kRecLoadZones(HPAGE hPage, LPCTSTR pFileName)
    RECERR kRecSaveZones(HPAGE hPage, LPCTSTR pFileName)
    RECERR kRecUpdateZone(HPAGE hPage, IMAGEINDEX iiImg, LPCZONE pZone, int nZone)
    RECERR kRecSetZoneLayout(HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRects, int nRects, int nZone)
    RECERR kRecGetOCRZoneCount(HPAGE hPage, int *pnOCRZones) nogil
    RECERR kRecGetOCRZoneInfo(HPAGE hPage, IMAGEINDEX iiImg, LPZONE pOCRZone, int nOCRZone) nogil
    RECERR kRecGetOCRZoneData(HPAGE hPage, IMAGEINDEX iiImg, LPZONEDATA pOCRZoneData, int nOCRZone)
    RECERR kRecGetOCRZoneLayout(HPAGE hPage, IMAGEINDEX iiImg, LPRECT *ppRects, int *pnRects, int nZone)
    RECERR kRecGetOCRZoneNodeArray(HPAGE hPage, IMAGEINDEX iiImg, LPPOINT *ppPoints, int *pnNodes, int iZone)
    RECERR kRecSaveOCRZones(HPAGE hPage, LPCTSTR pFileName)
    RECERR kRecUpdateOCRZone(HPAGE hPage, IMAGEINDEX iiImg, LPCZONE pZone, int nZone)

    # form recognition module
    # -----------------------
    ctypedef struct COMB_CELL_INFO:
        int left
        int right
    ctypedef void* HFORMTEMPLATEPAGE
    ctypedef void* HFORMTEMPLATECOLLECTION
    ctypedef void* FORMTEMPLATEMATCHINGID
    ctypedef BAR_ENA* LPBAR_ENA
    ctypedef const BAR_ENA* LPCBAR_ENA
    RECERR kRecCreateFormTemplate(int sid, HPAGE hPage)
    RECERR kRecSaveFormTemplate(int sid, HPAGE hPage, LPCTSTR pTemplateFilename)
    RECERR kRecLoadFormTemplate(int sid, HFORMTEMPLATEPAGE *phFormTemplatePage, LPCTSTR pTemplateFilename)
    RECERR kRecApplyFormTemplate(int sid, HPAGE hPage, HFORMTEMPLATEPAGE hFormTemplatePage)
    RECERR kRecFreeFormTemplate(HFORMTEMPLATEPAGE hFormTemplatePage)
    RECERR kRecApplyFormTemplateFile(int sid, HPAGE hPage, LPCTSTR pTemplateFilename)
    RECERR kRecSetZoneFormFieldName(HPAGE hPage, int nZone, LPCWSTR pFormFieldName)
    RECERR kRecSetOCRZoneFormFieldName(HPAGE hPage, int nZone, LPCWSTR pFormFieldName)
    RECERR kRecGetZoneFormFieldName(HPAGE hPage, int nZone, LPWSTR *ppFormFieldName)
    RECERR kRecGetOCRZoneFormFieldName(HPAGE hPage, int nZone, LPWSTR *ppFormFieldName)
    RECERR kRecSetZoneName(HPAGE hPage, int nZone, LPCTSTR pZoneName)
    RECERR kRecSetOCRZoneName(HPAGE hPage, int nZone, LPCTSTR pZoneName)
    RECERR kRecGetZoneName(HPAGE hPage, int nZone, LPTSTR *ppZoneName)
    RECERR kRecGetOCRZoneName(HPAGE hPage, int nZone, LPTSTR *ppZoneName)
    RECERR kRecGetNextZoneByName(HPAGE hPage, LPCTSTR pZoneName, int nPrevZone, int *nZone)
    RECERR kRecInsertAnchorZone(int sid, HPAGE hPage, ANCHORCONTENT aContent, ANCHORTYPE aType, int nZone)
    RECERR kRecUpdateAnchorZone(int sid, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, int nZone)
    RECERR kRecGetAnchorInfo(HPAGE hPage, int nZone, ANCHORCONTENT *aContent, ANCHORTYPE *aType)
    RECERR kRecSetAnchorContent(HPAGE hPage, int nZone, ANCHORCONTENT aContent)
    RECERR kRecSetAnchorType(HPAGE hPage, int nZone, ANCHORTYPE aType)
    RECERR kRecSetAnchorFlag(HPAGE hPage, int nZone, ANCHORFLAG flag, INTBOOL value)
    RECERR kRecGetAnchorFlag(HPAGE hPage, int nZone, ANCHORFLAG flag, INTBOOL *value)
    RECERR kRecSetAnchorText(HPAGE hPage, int nZone, LPCWSTR pText)
    RECERR kRecGetAnchorText(HPAGE hPage, int nZone, LPWSTR *ppText)
    RECERR kRecSetAnchorRegExp(HPAGE hPage, int nZone, LPCWSTR pRegExp)
    RECERR kRecGetAnchorRegExp(HPAGE hPage, int nZone, LPWSTR *ppRegExp)
    RECERR kRecSetAnchorDrift(HPAGE hPage, IMAGEINDEX iiImg, int nZone, SIZE drift)
    RECERR kRecGetAnchorDrift(HPAGE hPage, IMAGEINDEX iiImg, int nZone, SIZE *pDrift)
    RECERR kRecSetZoneBarTypes(HPAGE hPage, int nZone, LPCBAR_ENA pBarEna, INTBOOL BarBinary)
    RECERR kRecGetZoneBarTypes(int sid, HPAGE hPage, int nZone, LPBAR_ENA pBarEna, INTBOOL *pBarBinary, INTBOOL *pZoneLevel)
    RECERR kRecGetOCRZoneBarTypes(int sid, HPAGE hPage, int nZone, LPBAR_ENA pBarEna, INTBOOL *pBarBinary, INTBOOL *pZoneLevel)
    RECERR kRecSetAnchorRefPoint(HPAGE hPage, int nZone, ANCHOR_REF_POINT ref)
    RECERR kRecGetAnchorRefPoint(HPAGE hPage, int nZone, ANCHOR_REF_POINT *pref)
    RECERR kRecInsertDropOutColorZone(HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, int nZone)
    RECERR kRecGetDropOutColorZoneIndex(HPAGE hPage, int *pnZone)
    RECERR kRecSetFormTemplateName(HPAGE hPage, LPCTSTR pTemplateName)
    RECERR kRecGetFormTemplateName(HPAGE hPage, LPTSTR *pTemplateName)
    RECERR kRecCheckFormTemplate(int sid, HPAGE hPage)
    RECERR kRecSetZoneRefAnchors(HPAGE hPage, int nZone, REF_ANCHOR_MODE mode, const int *refAnchors)
    RECERR kRecGetZoneRefAnchors(HPAGE hPage, int nZone, REF_ANCHOR_MODE *pmode, int *refAnchors)
    RECERR kRecSetTemplateAttribute(HPAGE hPage, LPCTSTR key, LPCTSTR value)
    RECERR kRecGetTemplateAttribute(HPAGE hPage, LPCTSTR key, LPTSTR *pValue)
    RECERR kRecGetNextTemplateAttribute(HPAGE hPage, LPCTSTR prevkey, LPTSTR *key, LPTSTR *value)
    RECERR kRecSetZoneAttribute(HPAGE hPage, int nZone, LPCTSTR key, LPCTSTR value)
    RECERR kRecGetZoneAttribute(HPAGE hPage, int nZone, LPCTSTR key, LPTSTR *pValue)
    RECERR kRecGetOCRZoneAttribute(HPAGE hPage, int nZone, LPCTSTR key, LPTSTR *pValue)
    RECERR kRecGetNextZoneAttribute(HPAGE hPage, int nZone, LPCTSTR prevkey, LPTSTR *key, LPTSTR *value)
    RECERR kRecGetNextOCRZoneAttribute(HPAGE hPage, int nZone, LPCTSTR prevkey, LPTSTR *key, LPTSTR *value)
    RECERR kRecSetZoneOrder(HPAGE hPage, const int *order)
    RECERR kRecGetOCRZoneText(int sid, HPAGE hPage, int nZone, LPTSTR *pBuffer, int *len)
    RECERR kRecLoadFormTemplateLibrary(int sid, LPCTSTR pTmplLib, INTBOOL bLoadSTS, HFORMTEMPLATEPAGE **pphFormTmplArray, int *pLength)
    RECERR kRecFreeFormTemplateArray(HFORMTEMPLATEPAGE *phFormTmplArray, int Length, INTBOOL bFreeArray)
    RECERR kRecGetFormTemplateInfo(HFORMTEMPLATEPAGE hFormTmpl, LPTSTR *pFullName, LPTSTR *pFormPath, int *pFormPage)
    RECERR kRecFindFormTemplate(int sid, HPAGE hPage, HFORMTEMPLATEPAGE *phFormTmplArray, int Length, LPCTSTR FormPath, int FirstPage, int LastPage, HFORMTEMPLATECOLLECTION *phFormTmplCollection, FORMTEMPLATEMATCHINGID *pBestMatchingId, int *pConfidence, int *pnMatching)
    RECERR kRecGetFindFormTemplateInfo(HFORMTEMPLATECOLLECTION hFormTmplCollection, LPTSTR *pInfo)
    RECERR kRecGetNextMatchingTemplate(FORMTEMPLATEMATCHINGID PrevMatchingId, FORMTEMPLATEMATCHINGID *pNextMatchingId, int *pConfidence)
    RECERR kRecGetMatchingInfo(FORMTEMPLATEMATCHINGID MatchId, LPTSTR *pFullName, LPTSTR *pName, int *pPageNumber, int *pPageCount)
    RECERR kRecApplyFormTemplateEx(int sid, HPAGE hPage, FORMTEMPLATEMATCHINGID MatchingId)
    RECERR kRecFreeFormTemplateCollection(HFORMTEMPLATECOLLECTION hFormTmplCollection)
    RECERR kRecLocateComb(int sid, HPAGE hPage, int xZone)
    RECERR kRecCreateCombInfo(HPAGE hPage, int xZone, INTBOOL hasTopBorder, COMB_SPLITTER_HEIGHT splitterHeight)
    RECERR kRecDeleteCombInfo(HPAGE hPage, int xZone)
    RECERR kRecIsComb(HPAGE hPage, int xZone, INTBOOL *isComb)
    RECERR kRecGetCombCellCount(HPAGE hPage, int xZone, int *pnCells)
    RECERR kRecSetCombInfo(HPAGE hPage, int xZone, INTBOOL hasTopBorder, COMB_SPLITTER_HEIGHT splitterHeight)
    RECERR kRecGetCombInfo(HPAGE hPage, int xZone, INTBOOL *hasTopBorder, COMB_SPLITTER_HEIGHT *splitterHeight)
    RECERR kRecSetCombCells(HPAGE hPage, IMAGEINDEX iiImg, int xZone, const COMB_CELL_INFO *pCells, int nCells)
    RECERR kRecGetCombCells(HPAGE hPage, IMAGEINDEX iiImg, int xZone, COMB_CELL_INFO **ppCells, int *pnCells)

    # recognition module
    # ------------------
    ctypedef struct STATISTIC:
        int iChrNumber
        int iWordNumber
        int iChrRejected
        DWORD iRecognitionTime
        DWORD iReadingTime
        DWORD iScanTime
        DWORD iPreprocTime
        DWORD iDecompTime
    ctypedef STATISTIC* LPSTATISTIC
    ctypedef INTBOOL ONETOUCH_CB(INTBOOL bMore, void *pContext, LPCTSTR *notused)
    ctypedef ONETOUCH_CB *LPONETOUCH_CB
    ctypedef struct RPPERRORS:
        RECERR rc
        int page
        LPWSTR obj
        RPPERRORS* next
    RECERR kRecSetRMTradeoff(int sid, RMTRADEOFF Tradeoff)
    RECERR kRecGetRMTradeoff(int sid, RMTRADEOFF *pTradeoff)
    RECERR kRecSetDefaultFillingMethod(int sid, FILLINGMETHOD type)
    RECERR kRecGetDefaultFillingMethod(int sid, FILLINGMETHOD *ptype)
    RECERR kRecSetDefaultRecognitionModule(int sid, RECOGNITIONMODULE rm)
    RECERR kRecGetDefaultRecognitionModule(int sid, RECOGNITIONMODULE *rm)
    RECERR kRecSetTrainingFileName(int sid, LPCTSTR pFileName)
    RECERR kRecGetTrainingFileName(int sid, LPTSTR pFileName, size_t iSize)
    RECERR kRecRecognize(int sid, HPAGE hPage, LPCTSTR pFilename) nogil
    RECERR kRecProcessPages(int sid, LPCTSTR pDocFile, LPCTSTR *pImageFiles, LPONETOUCH_CB pCallback, void *pContext, LPCTSTR pTemplate)
    RECERR kRecProcessPagesEx(int sid, LPCTSTR pDocFile, LPCTSTR *pImageFiles, LPONETOUCH_CB pCallback, void *pContext, LPCTSTR pTemplate)
    RECERR kRecGetRPPErrorList(RPPERRORS **rppErrs)
    RECERR kRecGetStatistics(int sid, LPSTATISTIC pStat)

    # recognition data handling module
    # --------------------------------
    ctypedef struct LSPC:
        WORD spcCount
        BYTE spcType
        BYTE Res
    ctypedef union LETTER_UNION:
        DWORD ndxSuggestions
        LSPC spcInfo
    ctypedef struct LETTER:
        WORD  left
        WORD  top
        WORD  width
        WORD  height
        float pointSize
        WORD  capHeight
        WORD  baseLine
        WORD  zone
        WCHAR code
        BYTE  err
        BYTE  reserved_b
        BYTE  cntChoices
        BYTE  cntSuggestions
        DWORD ndxChoices
        DWORD ndxSuggestions
        #LETTER_UNION un
        WORD  fontAttrib
        WORD  ndxFontFace
        DWORD info
        WORD  makeup
        BYTE  widthULdot
        BYTE  widthULgap
        WORD  cellNum
        BYTE  ndxFGColor
        BYTE  ndxBGColor
        short lang
        short lang2
        DWORD ndxExt
    ctypedef LETTER* LPLETTER
    ctypedef const LETTER* LPCLETTER
    RECERR kRecGetLetters(HPAGE hPage, IMAGEINDEX iiImage, LPLETTER *ppLetter, LPLONG pLettersLength) nogil
    RECERR kRecGetLetterPalette(HPAGE hPage, REC_COLOR **ppColours, LPLONG pNum)
    RECERR kRecGetChoiceStr(HPAGE hPage, WCHAR **ppChoices, LPLONG pLength) nogil
    RECERR kRecGetSuggestionStr(HPAGE hPage, WCHAR **ppSuggestions, LPLONG pLength)
    RECERR kRecGetFontFaceStr(HPAGE hPage, char **ppFontFaces, LPLONG pLength)
    RECERR kRecSetLetters(LETTERSTRENGTH towhere, HPAGE hPage, IMAGEINDEX iiImage, LPCLETTER pLetter, LONG LettersLength)
    RECERR kRecFreeRecognitionData(HPAGE hPage)

    # language, charset and codepage handling module
    # ----------------------------------------------
    ctypedef OUTCODEPAGETYPE* LPOUTCODEPAGETYPE
    ctypedef struct LANGUAGE_INFO:
        BASIC_LANGUAGE_CHARSET iLangGroup
        CONTINENT iContinent
        char EnglishName [28]
        char Name_Int_3 [4]
        char Name_639_1 [3]
        char Name_639_2B [4]
        char Name_639_3 [4]
        char Name_Win_3 [4]
        WORD LangID
        RM_FLAGS rm_support
    RECERR kRecSetLanguages(int sid, LANG_ENA *pLanguages)
    RECERR kRecGetLanguages(int sid, LANG_ENA *pLanguages)
    RECERR kRecManageLanguages(int sid, MANAGE_LANG action, LANGUAGES language)
    RECERR kRecSetSingleLanguageDetection(int sid, INTBOOL bEnable)
    RECERR kRecGetSingleLanguageDetection(int sid, INTBOOL *pbEnable)
    RECERR kRecGetPageLanguages(HPAGE hPage, LANG_ENA *pOcrLanguages)
    RECERR kRecGetLanguageInfo(LANGUAGES lang, LANGUAGE_INFO *pInfo)
    RECERR kRecFindLanguages(const LANGUAGE_INFO *pInfo, LANG_ENA *pLanguages)
    RECERR kRecFindLanguage(LPCTSTR pLangName, LANGUAGES *pLanguage)
    RECERR kRecFindLanguageEx(LANGUAGE_CODE coding, LPCTSTR pLangName, LANGUAGES *pLanguage, LANG_ENA *pLanguages)
    RECERR kRecSetLanguagesPlus(int sid, LPCWSTR pOcrLplus)
    RECERR kRecGetLanguagesPlus(int sid, LPWSTR pOcrLplus, size_t iBSize)
    RECERR kRecSetDefaultFilter(int sid, CHR_FILTER Glfilter)
    RECERR kRecGetDefaultFilter(int sid, CHR_FILTER *pGlfilter)
    RECERR kRecSetFilterPlus(int sid, LPCWSTR pFilterPlus)
    RECERR kRecGetFilterPlus(int sid, LPWSTR pFilterPlus, size_t iSize)
    RECERR kRecSetRejectionSymbol(int sid, WCHAR wRej)
    RECERR kRecGetRejectionSymbol(int sid, LPWCH pwRej)
    RECERR kRecSetMissingSymbol(int sid, WCHAR wMiss)
    RECERR kRecGetMissingSymbol(int sid, LPWCH pwMiss)
    RECERR kRecSetCodePage(int sid, LPCTSTR pCodePageName)
    RECERR kRecGetCodePage(int sid, LPTSTR pCodePageName, size_t buflen)
    RECERR kRecGetCodePageInfo(LPCTSTR pCodePageName, LPTSTR pDesc, size_t size, LPOUTCODEPAGETYPE pCodePageType)
    RECERR kRecCheckCodePage(int sid, LPWSTR pMissingChrs, size_t buflen)
    RECERR kRecGetFirstCodePage(LPTSTR pCodePageName, size_t buflen)
    RECERR kRecGetNextCodePage(LPTSTR pCodePageName, size_t buflen)
    RECERR kRecConvertCodePage2Unicode(int sid, const LPBYTE pChar, size_t *pBuffLen, LPWCH pUniCode)
    RECERR kRecConvertUnicode2CodePage(int sid, WCHAR UniCode, LPBYTE pChar, size_t *pBuffLen)
        
    # direct TXT output converter module
    # ----------------------------------
    RECERR kRecSetDTXTFormat(int sid, DTXTOUTPUTFORMATS dFormat)
    RECERR kRecGetDTXTFormat(int sid, DTXTOUTPUTFORMATS *pdFormat)
    RECERR kRecConvert2DTXT(int sid, const HPAGE *ahPage, int nPage, LPCTSTR pFilename)
    RECERR kRecConvert2DTXTEx(int sid, const HPAGE *ahPage, int nPage, IMAGEINDEX iiImg, LPCTSTR pFilename)
    RECERR kRecMakePagesSearchable(int sid, LPCTSTR pFilename, int fromPage, const HPAGE *ahPage, int nPage, IMAGEINDEX iiImg)

    # document classifier module
    # --------------------------
    ctypedef struct RECDCSTRUCT:
        pass
    ctypedef RECDCSTRUCT* DCHANDLE
    ctypedef struct CLASSIFY_INFO:
        DCHANDLE hDCClass
        unsigned confidence
        short reserved1 [8]
        short reserved2 [8]
    RECERR kRecOpenDCProject(int sid, LPCTSTR pDCProjectFile, DCHANDLE *phDCProject)
    RECERR kRecCloseDCProject(DCHANDLE hDCProject)
    RECERR kRecGetFirstDCClass(DCHANDLE hDCProject, DCHANDLE *phDCClass)
    RECERR kRecGetNextDCClass(DCHANDLE hDCPrevClass, DCHANDLE *phDCClass)
    RECERR kRecClassifyPage(int sid, DCHANDLE hDCProject, HPAGE hPage, DCHANDLE *phDCPredictedClass, unsigned *pConfidenceLevel, CLASSIFY_INFO **pClassifyInfo, LPLONG pLength, INTBOOL *pIsConfident)
    RECERR kRecClassifyText(int sid, DCHANDLE hDCProject, LPCTSTR pText, DCHANDLE *phDCPredictedClass, unsigned *pConfidenceLevel, CLASSIFY_INFO **pClassifyInfo, LPLONG pLength, INTBOOL *pIsConfident)
    RECERR kRecClassifyDocument(int sid, DCHANDLE hDCProject, LPCTSTR pFileName, int iPage, DCHANDLE *phDCPredictedClass, unsigned *pConfidenceLevel, CLASSIFY_INFO **pClassifyInfo, LPLONG pLength, INTBOOL *pIsConfident)
    RECERR kRecGetDCClassName(DCHANDLE hDCClass, LPTSTR *ppName)
    RECERR kRecSetDCConfidenceThreshold(DCHANDLE hDCProject, int ConfidenceThreshold)
    RECERR kRecGetDCConfidenceThreshold(DCHANDLE hDCProject, int *pConfidenceThreshold)

cdef extern from "RecApiPlus.h":  

    # general service functions module
    # --------------------------------
    RECERR RecInitPlus(LPCTSTR pCompanyName, LPCTSTR pProductName)
    RECERR RecQuitPlus()
    RECERR RecSaveSettings(int sid, LPCTSTR pStsFile)
    RECERR RecLoadSettings(int sid, LPCTSTR pStsFile)
    RECERR RecSetDefaultSettings(int sid)
    RECERR RecSetOCRThreadCount(int sid, int thCount)
    RECERR RecGetOCRThreadCount(int sid, int *thCount)
 
    # simple multipage document handling module
    # -----------------------------------------
    ctypedef struct RECDOCSTRUCT:
        pass
    ctypedef RECDOCSTRUCT* HDOC
    RECERR RecCreateDoc(int sid, LPCTSTR pDocFile, HDOC *phDoc, int mode)
    RECERR RecOpenDoc(int sid, LPCTSTR pDocFile, HDOC *phDoc)
    RECERR RecCloseDoc(int sid, HDOC hDoc)
    RECERR RecDeleteDoc(LPCTSTR pDocName)
    RECERR RecSaveDoc(int sid, HDOC hDoc, LPCTSTR pDocFile)
    RECERR RecGetPageCount(int sid, HDOC hDoc, int *pnPages)
    RECERR RecInsertPage(int sid, HDOC hDoc, HPAGE hPage, int iPage)
    RECERR RecUpdatePage(int sid, HDOC hDoc, int iPage, HPAGE hPage)
    RECERR RecGetPage(int sid, HDOC hDoc, int iPage, HPAGE *phPage)
    RECERR RecDeletePage(int sid, HDOC hDoc, int iPage)
    RECERR RecMovePage(int sid, HDOC hDoc, int iPageFrom, int iPageTo)
    RECERR RecConvert2Doc(int sid, HDOC hDoc, LPCTSTR pOutputFilename)
    RECERR RecGetPageStatistics(int sid, HDOC hDoc, int iPage, STATISTIC *stat)
    RECERR RecCreatePageStore(int sid, HDOC hDoc, int storeId, HPAGE hPage)
    RECERR RecDeletePageStore(int sid, HDOC hDoc, int storeId)
    RECERR RecGetPageStore(int sid, HDOC hDoc, int storeId, HPAGE *phPage)
    RECERR RecFormatPageStore(int sid, HPAGE hPage)

    # one step functions module
    # -------------------------   
    RECERR RecProcessPagesEx(int sid, LPCTSTR pDocFile, LPCTSTR *pImageFiles, LPONETOUCH_CB pCallback, void *pContext)
    RECERR RecGetRPPErrorList(RPPERRORS **rppErrs)
    RECERR RecExecuteWorkflow(int sid, LPCTSTR pWFfilename)
