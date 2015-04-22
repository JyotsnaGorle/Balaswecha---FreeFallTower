import QtQuick 2.0
import "properties.js" as Constants


Image{
    id: bubble
    width: 220
    height: 50
    source:Constants.bubble
    z: 20
    opacity: 1

    property alias text: text.text
    signal clicked

    MouseArea{
        anchors.fill: parent
        onClicked: hide();
    }
property string bubletxt
    Text {
        id: text
        anchors.centerIn:bubble
//        wrapMode: Text.WordWrap
//        anchors.horizontalCenter: scale.horizontalCenter
        font.bold: true
        font.pointSize: 12
        color : "black"
        text: bubletxt
    }

    function hide(){
        visible = false;
    }
    function show(){
        visible = true;
    }
}
