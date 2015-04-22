import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {

    id: root
    visible: true
    width: 850
    height: 1000
    title: qsTr("Free Fall Tower")
    property variant win


    Image {
        anchors.fill: parent
        id: logo
        source: "images/logo.png"
   MouseArea{
   anchors.fill: parent
   onClicked: {


       var component = Qt.createComponent("main.qml");
                 win = component.createObject(root);
                 win.visible=true
       //TODO: Change this logic to STATE into WeighingMachine


   }}
   }

    }



