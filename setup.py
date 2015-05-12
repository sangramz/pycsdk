import sys
import os
import shutil

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

# clean previous build
for root, dirs, files in os.walk(".", topdown=False):
    for name in files:
        if (name.startswith("pycsdk") and not(name.endswith(".pyx") or name.endswith(".pxd"))):
            os.remove(os.path.join(root, name))
    for name in dirs:
        if (name == "build"):
            shutil.rmtree(name)

# build "myext.so" python extension to be added to "PYTHONPATH" afterwards...
setup(
    name='pycsdk',
    cmdclass = {'build_ext': build_ext},
    ext_modules = [
        Extension("pycsdk",
                  sources=["pycsdk.pyx"],
                  libraries=["kernelapi", "recpdf"],          # refers to "libexternlib.so"
                  # language="c++",                   # remove this if C and not C++
                  extra_compile_args=["-I/usr/local/include/nuance-omnipage-csdk-19.0", "-O2"],
                  extra_link_args=["-L/usr/local/lib/nuance-omnipage-csdk-lib64-19.0"]
             )
        ]
)
