 import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "properties.js" as Constants
import "event_handler.js" as EventHandler

ApplicationWindow {
    id: root
    visible: true
    width: 1300
    height: 1000
    title: qsTr("Free Fall Tower")
    property bool isVacuum: true
    property int slow: 4000
    property int medium: 1000
    property int fast: 500
    color: "#49BAB6"
    property bool inProgress: false

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }


    onInProgressChanged: {
        if(inProgress){
            leftKit.enabled = false;
            rightKit.enabled = false;
            scaleLeft.enabled = false;
            scaleRight.enabled = false;

        }
        else {
            leftKit.enabled = true;
            rightKit.enabled = true;
            scaleLeft.enabled = true;
            scaleRight.enabled = true;
        }

    }


    Rectangle {
        width: parent.width
        height: parent.height

        Rectangle{
            id: top
            height: root.height*0.7
            width: root.width
            color: root.color

            WeighingMachine {
                id: scaleLeft
                y: 451

                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.bottomMargin: -50
                onFootballClicked: {
                    bubbleStep1.hide();
                    EventHandler.onBallClicked(scaleLeft, "football")
                    bubbleStep2.show();
                }
                onIronballClicked:{
                    bubbleStep1.hide();
                    EventHandler.onBallClicked(scaleLeft, "ironball")
                    bubbleStep2.show();
                }
                onCottonballClicked:{
                    bubbleStep1.hide();
                    EventHandler.onBallClicked(scaleLeft, "cottonball")
                    bubbleStep2.show();
                }
                onGolfballClicked:{
                    bubbleStep1.hide();
                    EventHandler.onBallClicked(scaleLeft, "golfball")
                    bubbleStep2.show();
                }

                onBallClicked: {
                    freeFall.leftBallContainer.ballSource = scaleLeft.ball.source;
                    freeFall.leftBallContainer.ballWeight = scaleLeft.ball.weight;
                    freeFall.leftBallContainer.ballVisible = scaleLeft.ball.visible;
                    freeFall.leftBallContainer.ball.text = scaleLeft.ball.text;

                    scaleLeft.ball.visible = false;
                    freeFall.leftBallContainer.duration = root.medium;
                    freeFall.scale.spaceAboveScale.dropButton.visible = true

                    bubbleStep2.hide();
                    bubbleStep3.show();
                }

            }

            Item{
                id: clock
                property int seconds:leftTree.ballContainer.ball.timeTaken
                property int timeperiod:(seconds/360)*200
                x: 50
                y: 150
                Rectangle{
                    x: 194
                    y: 343
                    width:89
                    height: 93
                    color: "#f4c959"
                    radius: 44
                    Image {
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        source: Constants.clock
                    anchors.fill: parent
                    Item {
                        id:con
                        x: -4
                        y: 8
                    width: 300; height: 300
                        Rectangle {
                        id: rect
                        x: 10
                        y: 120
                        width: 8; height: 53; anchors.centerIn: parent
                        color: "black"
                        rotation: 0

                        anchors.verticalCenterOffset: -115
                        anchors.horizontalCenterOffset: -101
                        antialiasing: true

                        states:[ State {
                                name: "rotated"
                                PropertyChanges {
                                    target:rect;
                                    rotation:clock.seconds;
                            }

                            },
                            State {
                                name: "stop"
                                PropertyChanges {
                                    target: rect;
                                    rotation:0;
                                }
                            }
                        ]

                        transitions: Transition {
                            id:trans
                            RotationAnimation {
                                id:rotani
                                duration:clock.seconds
                                direction: RotationAnimation.Clockwise


                            }
                        }

                        Rectangle{
                            id:rect2
                            x: -3
                            y: 32
                            width:15
                            height: 21
                            color: "#f4c959"
                            anchors.rightMargin: -122
                            anchors.bottomMargin: -113
                            anchors.leftMargin: 122
                            anchors.topMargin: 113
                        }

                        }
                    }


                }
                }
                    function reset()
                    {
                    rect.state="stop"

                    }

            }


            Image{
                source: "images/logo.png"
                height:200
                width: 200
                anchors.left:parent.left
                anchors.top:parent.top
                anchors.topMargin: -50
                anchors.leftMargin: -45

            }

            BallsKit{
                id:leftKit
                anchors.left: parent.left
                anchors.leftMargin: 120
                anchors.top: parent.top
                anchors.topMargin: 15
                property variant win
                function reset()
                {
                    var component = Qt.createComponent("BallsKit.qml");
                    win = component.createObject(leftKit);
                    win.visible=true
                    //TODO: Change this logic to STATE into WeighingMachine
                }

            }



            Bubble {
                id: bubbleStep1
                bubletxt:"<br>Drag any ball to<br> the weighing machine"
                anchors.bottom: leftKit.bottom
                anchors.left: leftKit.right
                anchors.leftMargin: -60
                height:80
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bubbleStep1.hide()
                }
            }

            Rectangle{
                id:freeFall
                width: 400
                height: parent.height
                anchors.centerIn: parent
                color: root.color
                property alias leftBallContainer: leftTree.ballContainer
                property alias rightBallContainer: rightTree.ballContainer
                property alias scale : scale

                MonkeyTree{
                    id:leftTree
                    height: parent.height
                    width: parent.width*.35
                    anchors.right : scale.left
                    anchors.left: parent.left
                    color:root.color
                }

                Rectangle{
                    id:scale
                    width: 150
                    height: parent.height
                    color:parent.color
                    anchors.centerIn: parent
                    property alias spaceAboveScale : spaceAboveScale
                    Rectangle{
                        id:spaceAboveScale
                        width: parent.width
                        height: parent.height * .22
                        anchors.top: parent.top
                        color:"#49BAB6"
                        property alias dropButton : btnDrop

                        GroupBox {
                            id: mediumBox
                            title: "Medium:"
                            anchors.horizontalCenter: parent.horizontalCenter

                            Row {
                                ExclusiveGroup { id: tabPositionGroup }
                                spacing: 10

                                RadioButton {
                                    id: vacuum
                                    text: "Vacuum"
                                    //checked: true
                                    exclusiveGroup: tabPositionGroup
                                    onClicked: {
                                        isVacuum = true
                                    }
                                }
                                RadioButton {
                                    id: air
                                    text: "Air"
                                    exclusiveGroup: tabPositionGroup
                                    onClicked: {
                                        isVacuum = false
                                    }
                                }
                            }

                            function reset() {
                                vacuum.checked = true
                            }
                        }



                        Button2{
                            id: btnDrop
                            text: "Drop"
                            anchors.bottom:parent.bottom
                            visible: false
                            z:22


                            onClicked: {


                                inProgress = true;
                                bubbleStep3.hide();

                                if(!isVacuum){
                                    var exp = Math.exp((leftTree.currentHeight * 240)/leftTree.ballContainer.ball.weight);
                                    var acosh = Math.log(exp + Math.sqrt(exp * exp -1));
                                    leftTree.ballContainer.ball.timeTaken = 1000 *Math.sqrt(leftTree.ballContainer.ball.weight/(9.8 * 240))*acosh;
                                    if(rightTree.ballContainer.ball.weight != 0){
                                        exp = Math.exp((rightTree.currentHeight * 240)/rightTree.ballContainer.ball.weight);
                                        acosh = Math.log(exp + Math.sqrt(exp * exp -1));
                                        rightTree.ballContainer.ball.timeTaken = 1000 * Math.sqrt(rightTree.ballContainer.ball.weight/(9.8 * 240))*acosh;
                                        //rightTree.ballContainer.ball.timeTaken = Math.sqrt(200000 * rightTree.currentHeight / (9.8*rightTree.ballContainer.ball.weight)).toFixed(2)
                                    }
                                    freeFall.leftBallContainer.medium = "Air"
                                    freeFall.rightBallContainer.medium = "Air"
                                }
                                else{
                                    leftTree.ballContainer.ball.timeTaken = (1000 * Math.sqrt((2 * leftTree.currentHeight) / 9.8)).toFixed(2)
                                    rightTree.ballContainer.ball.timeTaken = (1000 * Math.sqrt((2 * rightTree.currentHeight) / 9.8)).toFixed(2)

                                    freeFall.leftBallContainer.medium = "Vaccum"
                                    freeFall.rightBallContainer.medium = "Vaccum"
                                }
                                if(leftTree.ballContainer.ball.timeTaken > rightTree.ballContainer.ball.timeTaken)
                                {
                                    freeFall.leftBallContainer.duration = slow;
                                    freeFall.rightBallContainer.duration = slow;
                                }
                                else if(leftTree.ballContainer.ball.timeTaken < rightTree.ballContainer.ball.timeTaken)
                                {
                                    freeFall.leftBallContainer.duration = slow
                                    freeFall.rightBallContainer.duration = slow
                                }
                                else{
                                    freeFall.leftBallContainer.duration = slow;
                                    freeFall.rightBallContainer.duration =slow;

                                }
                                freeFall.leftBallContainer.duration = leftTree.ballContainer.ball.timeTaken ;
                                freeFall.rightBallContainer.duration = rightTree.ballContainer.ball.timeTaken;

                                freeFall.leftBallContainer.ball.y = freeFall.leftBallContainer.height - freeFall.leftBallContainer.ball.height;
                                freeFall.rightBallContainer.ball.y = freeFall.rightBallContainer.height - freeFall.rightBallContainer.ball.height;
                                //console.log(freeFall.rightBallContainer.ball.x,freeFall.rightBallContainer.ball.y,freeFall.leftBallContainer.ball.x,freeFall.leftBallContainer.ball.y)
                                btnDrop.visible = false
                                btnReset.visible = true

                                if(leftTree.ballContainer.ballWeight !=0)
                                {
                                   rect.state="rotated"
                                }
                                if(rightTree.ballContainer.ballWeight !=0)
                                {
                                    rect1.state="rotated"
                                }

                            }

                        }


                        Button2{
                            id: btnReset
                            text: "Reset"
                            z:22
                            visible: false
                            anchors.bottom:parent.bottom

                            onClicked: {
                                btnReset.visible = false;
                                bubbleStep1.show();

                                rightTree.reset();
                                leftTree.reset();
                                scaleRight.reset();
                                scaleLeft.reset();
                                mediumBox.reset();
                                leftKit.reset();
                                rightKit.reset();
                                clock.reset();
                                clock1.reset();

                                inProgress = false;
                            }

                        }

                    }

                    Image{
                        id:rulerImg
                        source: Constants.rulerSource
                        width: parent.width-30
                        smooth: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:spaceAboveScale.bottom
                        anchors.bottom: parent.bottom
                    }

                    Item{
                        id: clock1
                        property int seconds:rightTree.ballContainer.ball.timeTaken
                        property int timeperiod:(seconds/360)*275
                        x: 90
                        y: 150
                        Rectangle{
                            x: 379
                            y: 344
                            width:89
                            height: 93
                            color: "#f4c959"
                            radius: 44
                            Image {
                                anchors.rightMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                source: Constants.clock
                            anchors.fill:parent
                            Item {
                                id:con1
                                x: -6
                                y: 8
                            width: 300; height: 300
                            Rectangle {
                                id: rect1
                                width: 8; height: 53; anchors.centerIn: parent
                                color: "black"
                                rotation: 0

                                anchors.verticalCenterOffset: -115
                                anchors.horizontalCenterOffset: -99
                                //                                antialiasing: true

                                states:[ State {
                                    name: "rotated"
                                    PropertyChanges { target:rect1; rotation:clock1.seconds;
                                    }
                                },
                                    State {
                                        name: "stop"
                                        PropertyChanges {
                                            target: rect1;
                                            rotation:0;
                                        }
                                    }
                                ]

                                transitions: Transition {
                                    RotationAnimation {
                                        duration:clock1.seconds;
                                        direction: RotationAnimation.Clockwise
                                    }
                                }


                                Rectangle{
                                    id:rect3
                                    x: -3
                                    y: 33
                                    width:15
                                    height: 20
                                    color: "#f4c959"
                                    anchors.rightMargin: -122
                                    anchors.bottomMargin: -113
                                    anchors.leftMargin: 122
                                    anchors.topMargin: 113
                                }

                            }

                            }
                        }
                    }
                            function reset()
                            {
                            rect1.state="stop"

                            }

                    }
                }

                MonkeyTree{
                    id:rightTree
                    height: parent.height
                    color:root.color
                    width: parent.width*.35
                    anchors.left : scale.right
                    anchors.right: parent.right
                }



                Bubble {
                    id: bubbleStep3
                    text: "<br>Select medium and<br> click on Drop"
                    anchors.top:rightTree.top
                    anchors.topMargin: 30
                    anchors.left: rightTree.left
                    width:150
                    height:80
                    visible: false
                    z:100
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: bubbleStep3.opacity=0.5
                        onClicked: bubbleStep3.hide()

                    }
                }
            }


            BallsKit{
                z:1
                id:rightKit
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.rightMargin: 80
                property variant win2
                function reset()
                {
                    var component2 = Qt.createComponent("BallsKit.qml");
                    win2 = component2.createObject(rightKit);
                    win2.visible=true
                }
            }


            WeighingMachine{
                id: scaleRight
                z:0
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -50
                anchors.rightMargin: 8
                onFootballClicked: {
                    EventHandler.onBallClicked(scaleRight, "football")
                }
                onIronballClicked:{
                    EventHandler.onBallClicked(scaleRight, "ironball")
                }
                onCottonballClicked:{
                    EventHandler.onBallClicked(scaleRight, "cottonball")

                }
                onGolfballClicked:{
                    EventHandler.onBallClicked(scaleRight, "golfball")
                }
                onBallClicked: {

                    freeFall.rightBallContainer.ballSource = scaleRight.ball.source;
                    freeFall.rightBallContainer.ballWeight = scaleRight.ball.weight;
                    freeFall.rightBallContainer.ballVisible = scaleRight.ball.visible;
                    freeFall.rightBallContainer.ball.text = scaleRight.ball.text

                    freeFall.rightBallContainer.duration = root.medium;
                    scaleRight.ball.visible = false;
                    freeFall.scale.spaceAboveScale.dropButton.visible = true
                }
            }


            Bubble {
                id: bubbleStep2
                text: "Slide to change weight and click the object"
                width: 350
                anchors.left: scaleLeft.right
                anchors.top:scaleLeft.bottom
                anchors.topMargin: -100
                visible: false


            }
        }

        Rectangle{
            id: bottom
            anchors.top: top.bottom
            anchors.bottom: parent.bottom
            width: root.width
            height:root.height/2

            property alias results: table.results


            ExperimentTable{
                id: table
                rotation: 0
                anchors.centerIn: parent
                anchors { fill: parent; topMargin: 6; bottomMargin: 6; leftMargin: 6; rightMargin: 6 }
            function append(side)
            {

                if(side=="left")
                {
                bottom.results.append({objects:freeFall.leftBallContainer.ball.text,height:leftTree.currentHeight, mass: freeFall.leftBallContainer.ball.weight, time_taken: leftTree.ballContainer.ball.timeTaken/1000, medium: freeFall.leftBallContainer.medium })
                console.log("left")
                }
                else if(side =="right")
                {
                bottom.results.append({objects:freeFall.rightBallContainer.ball.text,height:rightTree.currentHeight, mass: freeFall.rightBallContainer.ball.weight, time_taken: rightTree.ballContainer.ball.timeTaken/1000, medium: freeFall.rightBallContainer.medium })
                console.log("right")
                }
            }

            }

        }



}
}
