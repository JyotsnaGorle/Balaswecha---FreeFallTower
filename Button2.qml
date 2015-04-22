import QtQuick 2.0

Rectangle{
    id: root
    width: parent.width
    height: 30
    radius: 15
    color: "#FCDE4A"
    property alias text: btnText.text
    signal clicked;

    Text{
        id: btnText
        anchors.centerIn: parent
        text: "Pickup"
    }

    MouseArea{
        anchors.fill: parent
        onClicked:
            root.clicked();

    }

}
