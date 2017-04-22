ctypedef unsigned int RECERR

cdef extern from "RecApiPlus.h":
    ctypedef const char* LPCSTR
    ctypedef const char* LPCTSTR
    ctypedef char* LPTSTR
    ctypedef unsigned short* LPWSTR

    ctypedef unsigned char BYTE
    ctypedef unsigned short WCHAR
    ctypedef unsigned short WORD
    ctypedef unsigned int DWORD

    ctypedef int INTBOOL
    ctypedef int LONG
    ctypedef int* LPLONG
    
    # error handling module
    # ---------------------

    ctypedef enum RETCODEINFO:
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

    RECERR kRecGetLastError (LONG *pErrExt, LPTSTR pErrStr, int buflen)
    RECERR kRecGetLastErrorEx (LONG *pErrExt, LPTSTR *ppErrStr, LPTSTR *ppErrXml)
    RETCODEINFO kRecGetErrorInfo (RECERR ErrCode, LPCSTR *lpErrSym)
    RECERR kRecGetErrorUIText (RECERR ErrCode, LONG ErrExt, LPCTSTR lpErrStr, LPTSTR lpErrUIText, int *pBuffLen)
    
    # settings manager module
    # -----------------------
    
    ctypedef struct SEnumTypeElement:
        const char* id
        int value
    ctypedef struct RECSTSSTRUCT:
        pass
    ctypedef RECSTSSTRUCT* HSETTING
    ctypedef enum STSTYPES:
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
    
    RECERR kRecSettingGetHandle (HSETTING root_of_query, const char *symb_name, HSETTING *ret_handle, INTBOOL *has_setting)
    RECERR kRecSettingHasSetting (HSETTING node, INTBOOL *has_setting)
    RECERR kRecSettingGetType (HSETTING sett, STSTYPES *type)
    RECERR kRecSettingIsFlagSet (HSETTING sett, unsigned int flgs, INTBOOL *is_set)
    RECERR kRecSettingGetName (HSETTING node, const char **the_name)
    RECERR kRecSettingIsDefault (int sid, HSETTING node, INTBOOL *is_default)
    RECERR kRecSettingGetNextChild (HSETTING the_parent, HSETTING prev_child, HSETTING *the_child)
    RECERR kRecSettingGetCloneOrigin (HSETTING clone_node, HSETTING *origin_node)
    RECERR kRecSettingGetInt (int sid, HSETTING sett, int *the_value)
    RECERR kRecSettingGetDouble (int sid, HSETTING sett, double *the_value)
    RECERR kRecSettingGetString (int sid, HSETTING sett, const char **the_value)
    RECERR kRecSettingGetUString (int sid, HSETTING sett, const WCHAR **the_value)
    RECERR kRecSettingGetIntArray (int sid, HSETTING sett, const int **the_value)
    RECERR kRecSettingGetDoubleArray (int sid, HSETTING sett, const double **the_value)
    RECERR kRecSettingGetIntArrayAt (int sid, HSETTING sett, int index, int *the_value)
    RECERR kRecSettingGetDoubleArrayAt (int sid, HSETTING sett, int index, double *the_value)
    RECERR kRecSettingGetIntDefault (HSETTING sett, int *the_default)
    RECERR kRecSettingGetDoubleDefault (HSETTING sett, double *the_default)
    RECERR kRecSettingGetStringDefault (HSETTING sett, const char **the_default)
    RECERR kRecSettingGetUStringDefault (HSETTING sett, const WCHAR **the_default)
    RECERR kRecSettingGetIntArrayDefault (HSETTING sett, const int **the_default)
    RECERR kRecSettingGetDoubleArrayDefault (HSETTING sett, const double **the_default)
    RECERR kRecSettingGetSymbolic (int sid, HSETTING sett, char *the_value, unsigned int *buffer_size)
    RECERR kRecSettingGetIntArrayDefaultAt (HSETTING sett, int index, int *the_default)
    RECERR kRecSettingGetDoubleArrayDefaultAt (HSETTING sett, int index, double *the_default)
    RECERR kRecSettingGetNumberOfEnumElements (HSETTING sett, int *num_of_values)
    RECERR kRecSettingGetEnumElement (HSETTING sett, int index, const char **str_value, int *int_value)
    RECERR kRecSettingSetInt (int sid, HSETTING sett, int new_value)
    RECERR kRecSettingSetDouble (int sid, HSETTING sett, double new_value)
    RECERR kRecSettingSetString (int sid, HSETTING sett, const char *new_value)
    RECERR kRecSettingSetUString (int sid, HSETTING sett, const WCHAR *new_value)
    RECERR kRecSettingSetIntArray (int sid, HSETTING sett, const int *new_values)
    RECERR kRecSettingSetDoubleArray (int sid, HSETTING sett, const double *new_values)
    RECERR kRecSettingSetIntArrayAt (int sid, HSETTING sett, int index, int new_value)
    RECERR kRecSettingSetDoubleArrayAt (int sid, HSETTING sett, int index, double new_value)
    RECERR kRecSettingSetToDefault (int sid, HSETTING sett, INTBOOL whole_subtree)
    RECERR kRecSettingSetToDefaultPlusC (int sid, HSETTING sett, INTBOOL whole_subtree)
    RECERR kRecSettingSetArrayToDefaultAt (int sid, HSETTING sett, int index)
    RECERR kRecSettingSetArrayToDefaultAtPlusC (int sid, HSETTING sett, int index)
    RECERR kRecSettingGetSizeOfArray (HSETTING sett, int *the_size)
    RECERR kRecSettingCreateInt (HSETTING *created_setting, STSTYPES type, HSETTING root_of_creation, const char *symb_name, unsigned int flags, int def_value, const SEnumTypeElement *enum_elements)
    RECERR kRecSettingCreateDouble (HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, double def_value)
    RECERR kRecSettingCreateString (HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, const char *def_value)
    RECERR kRecSettingCreateUString (HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, unsigned int flags, const WCHAR *def_value)
    RECERR kRecSettingCreateIntArray (HSETTING *created_setting, STSTYPES type, HSETTING root_of_creation, const char *symb_name, int size, unsigned int flags, const int *def_values, const SEnumTypeElement *enum_elements)
    RECERR kRecSettingCreateDoubleArray (HSETTING *created_setting, HSETTING root_of_creation, const char *symb_name, int size, unsigned int flags, const double *def_values)
    RECERR kRecSettingDelete (HSETTING node)
    RECERR kRecSettingDeleteSubtree (HSETTING root_of_subtree)
    RECERR kRecSettingClone (HSETTING root_of_cloning, const char *new_symb_name)
    RECERR kRecSettingLoad (int sid, LPCTSTR filename)
    RECERR kRecSettingSave (int sid, HSETTING root_of_subtree, LPCTSTR filename, INTBOOL save_all, INTBOOL append)
    RECERR kRecSettingCopyValues (HSETTING node, int from_sid, int to_sid, INTBOOL whole_subtree)

    # image file handling module
    # --------------------------

    ctypedef struct tagIMGFILEHANDLE:
        pass
    ctypedef tagIMGFILEHANDLE* HIMGFILE
    ctypedef struct SIZE:
        int cx
        int cy
    ctypedef SIZE* LPSIZE
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
    ctypedef enum IMF_FORMAT:
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
    ctypedef enum IMF_IMAGEQUALITY:
        IMF_IMAGEQUALITY_MIN = 0
        IMF_IMAGEQUALITY_GOOD = 1
        IMF_IMAGEQUALITY_SUPERB = 2
    ctypedef enum IMF_MRCLEVEL:
        IMF_MRCLEVEL_NO = 0
        IMF_MRCLEVEL_MIN = 1
        IMF_MRCLEVEL_GOOD = 2
        IMF_MRCLEVEL_SUPERB = 3 
    ctypedef enum COMPRESSION_TRADEOFF:
        COMPRESSION_ADVANCED
        COMPRESSION_FAST 
    ctypedef enum IMF_PDFCOMPATIBILITY:
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
    ctypedef enum IMF_PDFENCRYPTION:
        IMF_PDFSECURITY_NONE
        IMF_PDFSECURITY_STANDARD
        IMF_PDFSECURITY_ENHANCED
        IMF_PDFSECURITY_AES
        IMF_PDFSECURITY_AES256
        IMF_PDFSECURITY_AES256X 
    ctypedef enum ENCRYPT_LEVEL:
        ENC_NOPAS = 0
        ENC_MUSTPAS = 1
        ENC_MASTER = 2
        ENC_USER = 4
        ENC_MUSTUSER = ENC_MUSTPAS | ENC_USER
        ENC_MUSTMASTER = ENC_MUSTPAS | ENC_MASTER
        ENC_MUSTANY = ENC_MUSTPAS | ENC_MASTER | ENC_USER
        ENC_NOACCESS = 8 
    RECERR kRecOpenImgFile (LPCTSTR pFilename, HIMGFILE *pHIMGFILE, int mode, IMF_FORMAT filetype)
    RECERR kRecCloseImgFile (HIMGFILE hIFile)
    RECERR kRecGetPDFEncLevel (HIMGFILE hIFile, ENCRYPT_LEVEL *pEncLev)
    RECERR kRecSetImfLoadFlags (int sid, DWORD fFlag)
    RECERR kRecGetImfLoadFlags (int sid, DWORD *pfFlag)
    RECERR kRecLoadImg (int sid, HIMGFILE hIFile, HPAGE *phPage, int iPage)
    RECERR kRecLoadImgF (int sid, LPCTSTR pFilename, HPAGE *phPage, int nPage)
    RECERR kRecLoadImgDataStream (int sid, HIMGFILE hIFile, HPAGE *phPage, int iPage)
    RECERR kRecLoadImgDataStreamF (int sid, LPCTSTR pFilename, HPAGE *phPage, int nPage)
    RECERR kRecDecompressImgDataStream (int sid, HPAGE hPage)
    RECERR kRecFreeImgDataStream (int sid, HPAGE hPage)
    RECERR kRecLoadImgM (int sid, BYTE *lpBitmap, LPCIMG_INFO lpImg, HPAGE *phPage)
    RECERR kRecLoadImgMC (int sid, BYTE *lpBuf, size_t bufLen, LPCCOMPRESSED_IMG_INFO lpCImg, HPAGE *phPage)
    RECERR kRecLoadImgDataStreamMC (int sid, BYTE *lpBuf, size_t bufLen, LPCOMPRESSED_IMG_INFO lpCImg, HPAGE *phPage)
    RECERR kRecSetCompressionLevel (int sid, int CompressionLevel)
    RECERR kRecGetCompressionLevel (int sid, int *pCompressionLevel)
    RECERR kRecSetCompressionTradeoff (int sid, COMPRESSION_TRADEOFF CompressionTradeoff)
    RECERR kRecGetCompressionTradeoff (int sid, COMPRESSION_TRADEOFF *pCompressionTradeoff)
    RECERR kRecSetMRCCompressionSettingsFromLevel (int sid, int CompressionLevel, COMPRESSION_TRADEOFF CompressionTradeOff)
    RECERR kRecSetJPGQuality (int sid, int nQuality)
    RECERR kRecGetJPGQuality (int sid, int *pnQuality)
    RECERR kRecSaveImg (int sid, HIMGFILE hIFile, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgForce (int sid, HIMGFILE hIFile, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgF (int sid, LPCTSTR pFilename, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX img, INTBOOL bAppend)
    RECERR kRecSaveImgForceF (int sid, LPCTSTR pFilename, IMF_FORMAT Imgfileformat, HPAGE hPage, IMAGEINDEX iiImg, INTBOOL bAppend)
    RECERR kRecSaveImgArea (int sid, HIMGFILE hIFile, IMF_FORMAT format, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, INTBOOL append)
    RECERR kRecSaveImgAreaF (int sid, LPCTSTR pFilename, IMF_FORMAT format, HPAGE hPage, IMAGEINDEX iiImg, LPCRECT pRect, INTBOOL append)
    RECERR kRecSetPdfPassword (HIMGFILE hIFile, LPCTSTR pwd)
    RECERR kRecSetPdfTagInfo (int sid, INTBOOL bUseTagInfo)
    RECERR kRecGetPdfTagInfo (int sid, INTBOOL *pbUseTagInfo)
    RECERR kRecGetImgFilePageCount (HIMGFILE hIFile, int *lpPageCount)
    RECERR kRecGetImgFilePageInfo (int sid, HIMGFILE hIFile, int nPage, LPIMG_INFO pImg, IMF_FORMAT *pFormat)
    RECERR kRecCopyImgFilePage (int sid, HIMGFILE hIFileDst, int ndstPage, HIMGFILE hIFileSrc, int nsrcPage)
    RECERR kRecDeleteImgFilePage (int sid, HIMGFILE hIFile, int nPage)
    RECERR kRecInsertImgFilePage (int sid, HPAGE hPage, IMAGEINDEX iiImg, HIMGFILE hIFile, int nPage, IMF_FORMAT format)
    RECERR kRecIsMultipageImgFileFormat (IMF_FORMAT imgfileformat, INTBOOL *bEnabled)
    RECERR kRecMatchImgFileFormat (int sid, HPAGE hPage, IMAGEINDEX iiImg, IMF_FORMAT imgfileformat, INTBOOL *match)
    RECERR kRecPackImgFile (int sid, LPCTSTR pFileName)
    RECERR kRecUpdateImgFilePage (int sid, HPAGE hPage, IMAGEINDEX iiImg, HIMGFILE hIFile, int nPage, IMF_FORMAT format)
    RECERR kRecReplaceImgFilePage (int sid, HIMGFILE hIFileDst, int ndstPage, HIMGFILE hIFileSrc, int nsrcPage)
    RECERR kRecGetImgFilePageIndex (HIMGFILE hIFile, int *pIndex)
        
    ctypedef enum FILLINGMETHOD:
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

    ctypedef enum RECOGNITIONMODULE:
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

    ctypedef enum CHR_FILTER:
        FILTER_DEFAULT = 0
        FILTER_DIGIT = 1
        FILTER_UPPERCASE = 2
        FILTER_LOWERCASE = 4
        FILTER_PUNCTUATION = 8
        FILTER_MISCELLANEOUS = 16
        FILTER_PLUS = 32
        FILTER_USER_DICT = 64
        FILTER_ALL
        FILTER_ALPHA = (FILTER_UPPERCASE | FILTER_LOWERCASE)
        FILTER_NUMBERS = (FILTER_DIGIT | FILTER_PLUS)
        FILTER_SIZE = 128

    ctypedef enum IMAGEINDEX:
        II_UNDEFINED = -1
        II_BGLAYER
        II_ORIGINAL
        II_CURRENT
        II_BW
        II_OCR
        II_THUMBNAIL
        II_OUTPUT
        II_SIZE

    ctypedef enum ZONETYPE:
        WT_FLOW
        WT_TABLE
        WT_GRAPHIC
        WT_AUTO
        WT_IGNORE
        WT_FORM
        WT_VERTTEXT
        WT_LEFTTEXT
        WT_RIGHTTEXT


    ctypedef enum DTXTOUTPUTFORMATS:
        DTXT_TXTS
        DTXT_TXTCSV
        DTXT_TXTF
        DTXT_PDFIOT
        DTXT_XMLCOORD
        DTXT_BINARY





    ctypedef struct RECT:
        int left
        int top
        int right
        int bottom
    ctypedef RECT* LPRECT

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
        WORD left
        WORD top
        WORD width
        WORD height
        float pointSize
        WORD capHeight
        WORD baseLine
        WORD zone
        WCHAR code
        BYTE err
        BYTE reserved_b
        BYTE cntChoices
        BYTE cntSuggestions
        DWORD ndxChoices
        LETTER_UNION un
    ctypedef LETTER* LPLETTER
    ctypedef const LETTER* LPCLETTER
    ctypedef enum LETTERSTRENGTH:
        LTS_FINAL 
        LTS_STRONG
        LTS_MEDIUM
        LTS_WEAK
        LTS_SIZE
    ctypedef DWORD REC_COLOR
    RECERR kRecGetLetters (HPAGE hPage, IMAGEINDEX iiImage, LPLETTER *ppLetter, LPLONG pLettersLength)
    RECERR kRecGetLetterPalette (HPAGE hPage, REC_COLOR **ppColours, LPLONG pNum)
    RECERR kRecGetChoiceStr (HPAGE hPage, WCHAR **ppChoices, LPLONG pLength)
    RECERR kRecGetSuggestionStr (HPAGE hPage, WCHAR **ppSuggestions, LPLONG pLength)
    RECERR kRecGetFontFaceStr (HPAGE hPage, char **ppFontFaces, LPLONG pLength)
    RECERR kRecSetLetters (LETTERSTRENGTH towhere, HPAGE hPage, IMAGEINDEX iiImage, LPCLETTER pLetter, LONG LettersLength)
    RECERR kRecFreeRecognitionData (HPAGE hPage)

    RECERR kRecFreeImg(HPAGE hPage)
    RECERR kRecQuit()
    RECERR kRecSetLicense(LPCSTR pLicenseFile, LPCSTR pCode)
    RECERR kRecInit(LPCSTR pCompanyName, LPCSTR pProductName)
    RECERR kRecOpenImgFile(LPCSTR pFilename, HIMGFILE *pHIMGFILE, int mode, IMF_FORMAT filetype)
    RECERR kRecGetImgFilePageCount(HIMGFILE hlFILE, int *lpPagecount)
    RECERR kRecLoadImg(int sid, HIMGFILE hlFILE, HPAGE *phPAGE, int iPage)
    RECERR kRecGetImgInfo(int sid, HPAGE hPAGE, IMAGEINDEX iiImage, LPIMG_INFO pImg)
    RECERR kRecSetNongriddedTableDetect(int sid, INTBOOL bForceSingle)
    RECERR kRecSetForceSingleColumn(int sid, INTBOOL bForceSingle)
    RECERR kRecLocateZones(int sid, HPAGE hPAGE)
    RECERR kRecRecognize(int sid, HPAGE hPAGE, LPCSTR pFilename)
    RECERR kRecCopyOCRZones(HPAGE hPage)
    RECERR kRecGetZoneCount(HPAGE hPage, int *pnZones)
    RECERR kRecGetZoneInfo(HPAGE hPage, IMAGEINDEX iiImg, LPZONE pZone, int nZone)
    RECERR kRecDeleteAllZones(HPAGE hPage)
    RECERR kRecInsertZone(HPAGE hPage, IMAGEINDEX iiImg, LPCZONE pZone, int nZone)
    RECERR kRecSetDTXTFormat(int sid, DTXTOUTPUTFORMATS dFormat)
    RECERR kRecConvert2DTXT(int sid, const HPAGE *ahPage, int nPage, LPCTSTR pFilename)

    RECERR RecInitPlus(LPCTSTR pCompanyName, LPCTSTR pProductName)
    RECERR RecQuitPlus()
    RECERR RecSaveSettings(int sid, LPCTSTR pStsFile)
    RECERR RecLoadSettings(int sid, LPCTSTR pStsFile)
    RECERR RecSetDefaultSettings(int sid)
    RECERR RecSetOCRThreadCount(int sid, int thCount)
    RECERR RecGetOCRThreadCount(int sid, int *thCount)

    ctypedef struct RECDOCSTRUCT:
        pass

    ctypedef RECDOCSTRUCT* HDOC

    ctypedef struct STATISTIC:
        int iChrNumber
        int iWordNumber
        int iChrRejected
        DWORD iRecognitionTime
        DWORD iReadingTime
        DWORD iScanTime
        DWORD iPreprocTime
        DWORD iDecompTime

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

    ctypedef INTBOOL ONETOUCH_CB(INTBOOL bMore, void *pContext, LPCTSTR *notused)
    ctypedef ONETOUCH_CB *LPONETOUCH_CB
    ctypedef struct RPPERRORS:
        RECERR rc
        int page
        LPWSTR obj
        RPPERRORS* next

    RECERR RecProcessPagesEx(int sid, LPCTSTR pDocFile, LPCTSTR *pImageFiles, LPONETOUCH_CB pCallback, void *pContext)
    RECERR RecGetRPPErrorList(RPPERRORS **rppErrs)
    RECERR RecExecuteWorkflow(int sid, LPCTSTR pWFfilename)


