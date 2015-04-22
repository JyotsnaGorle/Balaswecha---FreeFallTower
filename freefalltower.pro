TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES += \
    qml/main.qml \
    qml/Ball.qml

CONFIG+=app_bundle

# Default rules for deployment.
include(deployment.pri)

#QMAKE_MAC_SDK = macosx10.9

DISTFILES +=
