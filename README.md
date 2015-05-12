##pyCSDK

A Python/Cython wrapper for the Omnipage CSDK.

###Install

First, set LD_LIBRARY_PATH to point to the SDK shared libraries

For example:

    export LD_LIBRARY_PATH=/usr/local/lib/nuance-omnipage-csdk-lib64-19.0/:$LD_LIBRARY_PATH

Next, clone this repo, enter the directory and

    python setup.py install

If the install fails, you may have to edit the paths pointing to the SDK include files and shared libraries. The can be found in `setup.py`

###Usage

    import pycsdk
    scanner = pycsdk.CSDK("path to the license file", "license key")


....
