######################################################################
# Automatically generated by qmake (2.01a) Wed Mar 4 01:10:02 2009
######################################################################
EXTERNAL_BASE_PATH = ../
include($$EXTERNAL_BASE_PATH/ext_common.pri)
TEMPLATE = lib
TARGET = bz2
CONFIG += staticlib
DEPENDPATH += .
INCLUDEPATH += .
macx:QMAKE_CFLAGS += -Wno-unused-parameter -Wno-format -Wno-pointer-sign
macx:QMAKE_CFLAGS_WARN_ON = 
# Input
HEADERS += bzlib.h bzlib_private.h
SOURCES += blocksort.c \
           bzip2.c \
           bzip2recover.c \
           bzlib.c \
           compress.c \
           crctable.c \
           decompress.c \
           dlltest.c \
           huffman.c \
           mk251.c \
           randtable.c \
           spewG.c \
           unzcrash.c
