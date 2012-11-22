#!/usr/bin/env python

from distutils.core import setup
from Cython.Distutils import Extension, build_ext

#------------------------------------------------------------------------
# Extension
#------------------------------------------------------------------------

extensions = [
    Extension( "pynanomsg.constants",
               ["pynanomsg/constants.pyx"],
               libraries=['nanomsg'],
   ),
    Extension( "pynanomsg.socket",
               ["pynanomsg/socket.pyx"],
               libraries=['nanomsg'],
   ),
]

#------------------------------------------------------------------------
# Setup
#------------------------------------------------------------------------

setup(
    name='pynanomsg',
    version='dev',
    author_email='stephen.m.diehl@gmail.com',
    description='Python bindings for nanomsg',
    data_files=[],
    entry_points={},
    license='MIT',
    platforms = ['any'],
    classifiers=[],
    packages='pynanomsg',
    install_requires=[''],
    cmdclass = {
        'build_ext' : build_ext,
    },
    ext_modules=extensions,
)
