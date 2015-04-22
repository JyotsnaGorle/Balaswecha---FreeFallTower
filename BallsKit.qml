import QtQuick 2.0
import "properties.js" as Constants

Item {
    id: root
    width: 100
    height: 100

    Grid{
        id: grid
        rows: 2; columns: 2; spacing: 4

        Ball {
            id:footBall
            property string balltype:"football"
            source: Constants.source("football")
            text: Constants.text("football")
            Drag.active: fballmarea.drag.active
            Drag.source: footBall
            MouseArea{
                id:fballmarea
                hoverEnabled: true
                onEntered: parent.scale=1.2
                onExited: parent.scale=1
                anchors.fill: parent
                drag.target: parent
                onReleased: parent.Drag.drop()
            }
        }

        Ball {
            property string balltype:"golfball"
            id:golfBall
            source: Constants.source("golfball")
            text: Constants.text("golfball")
            Drag.active: golballmarea.drag.active
            Drag.source: golfBall
           MouseArea{
               id:golballmarea
               hoverEnabled: true
               onEntered: parent.scale=1.2
               onExited: parent.scale=1
               anchors.fill: parent
               drag.target: parent
               onReleased: parent.Drag.drop()
                    }
        }
        Ball {
            property string balltype:"ironball"
            id:ironBall
            source: Constants.source("ironball")
            text: Constants.text("ironball")
            Drag.active: ironballmarea.drag.active
            Drag.source: ironBall
           MouseArea{
               hoverEnabled: true
               onEntered: parent.scale=1.2
               onExited: parent.scale=1
               id:ironballmarea
               anchors.fill: parent
               drag.target: parent
               onReleased: parent.Drag.drop()
                    }

        }
        Ball {
            property string balltype:"cottonball"
            id:cottonBall
            source: Constants.source("cottonball")
            text: Constants.text("cottonball")
            Drag.active: cotballmarea.drag.active
                    Drag.source: cottonBall
           MouseArea{
               hoverEnabled: true
               onEntered: parent.scale=1.2
               onExited: parent.scale=1
               id:cotballmarea
               anchors.fill: parent
               drag.target: parent
               onReleased: parent.Drag.drop()}
        }
    }


}

