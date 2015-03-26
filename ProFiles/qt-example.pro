TEMPLATE	= app

TARGET = LS1-Remote

LIB_DIR   = ../libs
SRC_DIR		= ../src
CORE_DIR 	= $$SRC_DIR/core
GUI_DIR		= $$SRC_DIR/gui
INCLUDEPATH    += $$SRC_DIR \
                  $$CORE_DIR \
                  $$GUI_DIR \
                  $$LIB_DIR/PortMidi/include \
                  $$LIB_DIR/tinyxml \
                  $$LIB_DIR/MidiFileIn

win32:INCLUDEPATH += $$SRC_DIR/win
macx:INCLUDEPATH += $$SRC_DIR/osx
unix:!macx:INCLUDEPATH += /usr/lib

# Application is multithreaded and with debug mode
CONFIG += qt thread build_all

QT += core gui network

include($$LIB_DIR/QtSolutions/qtsingleapplication/src/qtsingleapplication.pri)

# Installed portmidi via Homebrew on mac
macx:LIBS+= -L/usr/local/Cellar/portmidi/217/lib -lportmidi
#-framework AppKit -framework Foundation

win32 {
	LIBS += -L"$$LIB_DIR/PortMidi/lib" -lportmidi_s -lwinmm -lAdvapi32
}
# Installed portmidi via apt-get install libportmidi
unix:!macx:LIBS+= -lportmidi -lporttime

# TinyXML
HEADERS	    +=  $$LIB_DIR/tinyxml/tinyxml.h \
                $$LIB_DIR/tinyxml/tinystr.h \
                $$LIB_DIR/tinyxml/lstring.h
SOURCES	    +=  $$LIB_DIR/tinyxml/tinyxml.cpp \
                $$LIB_DIR/tinyxml/tinystr.cpp \
                $$LIB_DIR/tinyxml/tinyxmlerror.cpp \
                $$LIB_DIR/tinyxml/tinyxmlparser.cpp


HEADERS        += $$SRC_DIR/SVN2Version.h \
                  $$SRC_DIR/Version.h \
                  $$SRC_DIR/Definitions.h \
                  $$SRC_DIR/Style.h \
                  $$CORE_DIR/Ls1Core.h \
                  $$CORE_DIR/MidiCommandos.h \
                  $$CORE_DIR/PortMidiWrapper.h \
                  $$GUI_DIR/BalanceControl.h \
                  $$GUI_DIR/BalanceSlider.h \
                  $$GUI_DIR/EqAmplSlider.h \
                  $$GUI_DIR/filtercalc.h \
                  $$GUI_DIR/MidiSelector.h \
                  $$GUI_DIR/OffsetSlider.h \
                  $$GUI_DIR/PrefEq.h \
                  $$GUI_DIR/PreferencesDock.h \
                  $$GUI_DIR/PrefLs1.h \
                  $$GUI_DIR/PrefOffsets.h \
                  $$GUI_DIR/PrefProSettings.h \
                  $$GUI_DIR/PrefRemote.h \
                  $$GUI_DIR/PrefSystem.h \
                  $$GUI_DIR/PrefWoofers.h \
                  $$GUI_DIR/QDialEndless.h \
                  $$GUI_DIR/qledindicator.h \
                  $$GUI_DIR/WaitDialog.h \
                  $$GUI_DIR/MainWindow.h
SOURCES        += $$SRC_DIR/SVN2Version.cpp \
                  $$SRC_DIR/LS1-Remote.cpp \
                  $$CORE_DIR/Ls1Core.cpp \
                  $$CORE_DIR/MidiCommandos.cpp \
                  $$CORE_DIR/PortMidiWrapper.cpp \
                  $$GUI_DIR/BalanceControl.cpp \
                  $$GUI_DIR/BalanceSlider.cpp \
                  $$GUI_DIR/EqAmplSlider.cpp \
                  $$GUI_DIR/filtercalc.cpp \
                  $$GUI_DIR/MidiSelector.cpp \
                  $$GUI_DIR/OffsetSlider.cpp \
                  $$GUI_DIR/PrefEq.cpp \
                  $$GUI_DIR/PreferencesDock.cpp \
                  $$GUI_DIR/PrefLs1.cpp \
                  $$GUI_DIR/PrefOffsets.cpp \
                  $$GUI_DIR/PrefProSettings.cpp \
                  $$GUI_DIR/PrefRemote.cpp \
                  $$GUI_DIR/PrefSystem.cpp \
                  $$GUI_DIR/PrefWoofers.cpp \
                  $$GUI_DIR/QDialEndless.cpp \
                  $$GUI_DIR/qledindicator.cpp \
                  $$GUI_DIR/WaitDialog.cpp \
                  $$GUI_DIR/MainWindow.cpp

win32 {
    HEADERS += $$SRC_DIR/win/targetver.h
	#HEADERS += $$SRC_DIR/win/stdafx.h $$SRC_DIR/win/targetver.h
	#SOURCES += $$SRC_DIR/win/stdafx.cpp
}

macx {
	SOURCES += $$SRC_DIR/osx/MacDial.cpp
	HEADERS += $$SRC_DIR/osx/MacDial.h
}

CONFIG(debug, debug|release) {
    DEFINES += "DO_DEBUG"
    unix:!macx {
        DESTDIR			= ../builds/unix/debug
        TARGET			= $$join(TARGET,,,_debug)
    }
    macx {
        DESTDIR			= ../builds/mac/debug
        TARGET			= $$join(TARGET,,,_debug)
    }
    win32 {
        DESTDIR			= ../builds/win/debug
        TARGET = $$join(TARGET,,d)
    }
} else {
    unix:!macx:DESTDIR		= ../builds/unix/release
    macx:DESTDIR		= ../builds/mac/release
    win32:DESTDIR		= ../builds/win/release
}

MOC_DIR		= $$DESTDIR/mocced
OBJECTS_DIR	= $$DESTDIR/objects
RCC_DIR		= $$DESTDIR/resource

RESOURCES = ../resources/ls1.qrc
win32:RC_FILE = ../resources/ls1.rc
macx:ICON = ../resources/images/prod_ls1.icns

