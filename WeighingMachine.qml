import QtQuick 2.0
import QtQuick.Controls 1.2
import "properties.js" as Constants
import "event_handler.js" as EventHandler

Rectangle{
    id: root
    width: 200
    height: 300
    color: "#4abbb4"
    property alias text: weightText.text
    signal onSlideValueChanged;
    property alias slideValue: slider.value
    property alias ball:  ball
    property alias ballText: labelText.text
    property alias anim: anim
    signal ballClicked
     signal footballClicked;
    signal golfballClicked;
    signal ironballClicked;
    signal cottonballClicked;

    Ball{
        id: ball
        x: scale.x + (scale.width-width)/2
        y: 0
        source:""
        anchors.bottom: scale.top
        visible: false
        weight: 0

        onClicked: {
            root.ballClicked();
        }
    }

    ParallelAnimation{
        id: anim
        NumberAnimation{
            target: ball
            properties:x
            to: 242
            duration: 200
        }
        NumberAnimation{
            target: ball
            properties:y
            to: 52
            duration: 200
        }
    }
Rectangle{
    DropArea{
        anchors.fill: parent

        onEntered: {
        drag.source.opacity=0.5
        }
        onExited: {
            drag.source.opacity=1
        }

        onDropped: {

            if(drag.source.balltype==="football")
            root.footballClicked();

            if(drag.source.balltype==="golfball")
            root.golfballClicked();

            if(drag.source.balltype==="ironball")
            root.ironballClicked();

            if(drag.source.balltype==="cottonball")
            root.cottonballClicked();

             drag.source.visible=false
            weightText.text="100kg"
            bubbleStep2.visible=true
        }

    }

    id:objDropArea
anchors{
bottom:scale.top
horizontalCenter: scale.horizontalCenter
}
width:scale.width
height: 100
opacity:0

}
    Image {

        id: scale
        y:30
        width:120
        height:180
        source: "images/scale.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
    id: weightText

    anchors.horizontalCenter: scale.horizontalCenter
    y:scale.y + scale.height - 50
    font.bold: true
    font.pointSize: 20
    color : "#FCEA5D"
    text: "0.0"
    }

    Slider{
        id: slider
        anchors.top: scale.bottom
        anchors.margins: 5
        anchors.bottom: labelText.top
        anchors.topMargin: -10

        maximumValue: 500
        stepSize: 50
        minimumValue: 100
        Component.onCompleted: weightText.text="0 kg"
        onValueChanged: {
            ball.weight = value;
            weightText.text = value + Constants.weightMeasureUnit
            root.onSlideValueChanged();
        }
    }

    Text {
        id: labelText
        anchors.top: slider.Bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        text: ""
    }

    function reset(){
        slider.value = 0;
        ballText = "";
        ball.reset();
        weightText.text="0 Kg"
    }


}
