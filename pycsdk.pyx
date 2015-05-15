import os
from cpython.mem cimport PyMem_Malloc, PyMem_Free

cdef class CSDK:
    cdef HIMGFILE pHIMGFILE
    cdef HPAGE hPAGE
    cdef readonly int page_count
    cdef readonly int zone_count
    cdef readonly unsigned int current_page
    cdef RECERR err_code
    scanned = False

    def __cinit__(self, license_file, license_key):
        license_abspath = os.path.abspath(license_file)
        cdef LPCSTR pLicenseFile = license_abspath
        cdef LPCSTR key = license_key
        # Load the License information
        self.err_code = kRecSetLicense(pLicenseFile, key)
        if self.err_code != 0:
            raise Exception("OmniPage: licensing error: {:08x}".format(self.err_code))
        # Initialize the scanning software
        self.err_code = kRecInit("pycsdk", "pycsdk")
        if self.err_code != 0:
            raise Exception("OmniPage: initialization error: {:08x}".format(self.err_code))
        # set Decomp method
        self.err_code = kRecSetNongriddedTableDetect(0, 1)
        if self.err_code != 0:
            raise Exception("OmniPage: SetNongriddedTableDetect error: {:08x}".format(self.err_code))
        # # Set single column mode
        # self.err_code = kRecSetForceSingleColumn(0, 1)
        # if self.err_code != 0:
        #     raise Exception("OmniPage: SetForceSingleColumn error: {:08x}".format(self.err_code))

    def __dealloc__(self):
        # if we've loaded an image, free it
        if self.hPAGE:
            self.free_image()
        # Deallocate and quit
        self.err_code = kRecQuit()
        if self.err_code != 0:
            raise Exception("OmniPage: quit error: {:08x}".format(self.err_code))

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        pass

    def load_file(self, input_file):
        cdef LPCSTR in_file = input_file
        # Open the image file
        self.err_code = kRecOpenImgFile(input_file, &self.pHIMGFILE, 0, FF_TIFNO)
        if self.err_code != 0:
            raise Exception("OmniPage: file open error: {:08x}".format(self.err_code))
        # Get a page count
        self.err_code = kRecGetImgFilePageCount(self.pHIMGFILE, &self.page_count)
        if self.err_code != 0:
            raise Exception("OmniPage: page count error: {:08x}".format(self.err_code))
        self.current_page = 0

    def load_image(self, page_number):
        # Make sure we've loaded a file
        if not self.pHIMGFILE:
            raise Exception("pyCSDK: load_image called without a loaded file.")
        # Load a single image from the image file
        self.err_code = kRecLoadImg(0, self.pHIMGFILE, &self.hPAGE, page_number)
        if self.err_code != 0:
            raise Exception("OmniPage: image load error: {:08x}".format(self.err_code))
        self.current_page = page_number

    def find_zones(self):
        # Make sure we've loaded an image from the file
        if not self.hPAGE:
            raise Exception("pyCSDK: find_zones called without a loaded image.")
        # Auto recognize the zones in an image
        self.err_code = kRecLocateZones(0, self.hPAGE)
        if self.err_code != 0:
            raise Exception("OmniPage: locate zones: {:08x}".format(self.err_code))
        self.err_code = kRecRecognize(0, self.hPAGE, NULL)
        if self.err_code != 0:
            raise Exception("OmniPage: zone recognize: {:08x}".format(self.err_code))
        self.err_code = kRecCopyOCRZones(self.hPAGE)
        if self.err_code != 0:
            raise Exception("OmniPage: zone copy: {:08x}".format(self.err_code))
        self.err_code = kRecGetZoneCount(self.hPAGE, &self.zone_count)
        if self.err_code != 0:
            raise Exception("OmniPage: get zone count: {:08x}".format(self.err_code))
        # Return the list of zones found
        return self.get_zones()

    def get_zones(self):
        cdef ZONE zone
        zone_list = []
        # Iterate through the zones, building a python list
        for x in range(self.zone_count):
            self.err_code = kRecGetZoneInfo(self.hPAGE, II_CURRENT, &zone, x)
            if self.err_code != 0:
                raise Exception("OmniPage: get zone info: {:08x}".format(self.err_code))
            zone_list.append(zone.copy())
        return zone_list

    def write_zones(self, zones):
        cdef ZONE zone
        # Make sure we've loaded an image
        if not self.hPAGE:
            raise Exception("pyCSDK: write_zones called without a loaded image.")
        # Delete all the existing zones
        self.err_code = kRecDeleteAllZones(self.hPAGE)
        if self.err_code != 0:
            raise Exception("OmniPage: delete zones error: {:08x}".format(self.err_code))
        # Write the new zone list to the SDK data structure
        for i, z in enumerate(zones):
            zone = z
            self.err_code = kRecInsertZone(self.hPAGE, II_CURRENT, &zone, i)
            if self.err_code != 0:
                raise Exception("OmniPage: insert zone error: {:08x}".format(self.err_code))

    def scan(self):
        # Make sure we've loaded an image
        if not self.hPAGE:
            raise Exception("pyCSDK: scan called without a loaded image.")
        # do the actual scanning
        self.err_code = kRecRecognize(0, self.hPAGE, NULL)
        if self.err_code != 0:
            raise Exception("OmniPage: zone recognize: {:08x}".format(self.err_code))
        self.scanned = True

    def write_scan(self, output_file, DTXTOUTPUTFORMATS format):
        # Check to see if we've scanned the image already, do so if we haven't
        if not self.scanned:
           self.scan()
           self.scanned = True
        cdef LPCSTR pFilename = output_file
        # Set the output format
        self.err_code = kRecSetDTXTFormat(0, format)
        if self.err_code != 0:
            raise Exception("OmniPage: set DTXT format: {:08x}".format(self.err_code))
        # Write the output to a file
        self.err_code = kRecConvert2DTXT(0, &self.hPAGE, self.current_page, pFilename)
        if self.err_code != 0:
            raise Exception("OmniPage: write DTXT output: {:08x}".format(self.err_code))

    def write_csv(self, output_file):
        self.write_scan(output_file, DTXT_TXTCSV)

    def write_xml(self, output_file):
        self.write_scan(output_file, DTXT_XMLCOORD)

    def free_image(self):
        # Make sure we actually have something to free
        if self.hPAGE:
            self.err_code = kRecFreeImg(self.hPAGE)
            if self.err_code != 0:
                raise Exception("OmniPage: free error: {:08x}".format(self.err_code))
