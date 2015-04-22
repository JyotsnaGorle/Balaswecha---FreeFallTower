import QtQuick 2.0
import QtQuick.Controls 1.2
import "properties.js" as Constants


Rectangle {
    id: resultsTable
    property alias results : results

    ListModel {
       id: results
    }

    TableView {
        id:tbl

        width: parent.width
        height: parent.height

        TableViewColumn{ role: "objects"  ; title: "Object" ; width: parent.width*.20 }
        TableViewColumn{ role: "mass" ; title: "Mass (kg)" ; width: parent.width*.20 }
        TableViewColumn{ role: "height" ; title: "Height (m)" ; width: parent.width*.20 }
        TableViewColumn{ role: "time_taken" ; title: "Time (s)" ; width: parent.width*.20 }
        TableViewColumn{ role: "medium" ; title: "Medium" ; width: parent.width*.20 }

        model: results


       headerDelegate: Rectangle {
           height: textItem.implicitHeight * 1.2
           width: textItem.implicitWidth*1.2
           color: "orange"
           border.color: "#F2F5A9"
           border.width: 1
           Text {
               id: textItem
               anchors.fill: parent
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: styleData.textAlignment
               anchors.leftMargin: 12
               text: styleData.value
               elide: Text.ElideRight
               color: "black"
               renderType: Text.NativeRendering
           }

       }

        rowDelegate:Rectangle {
            height: textItemrow.implicitHeight*1.2
            width:textItemrow.implicitWidth
            color:"#F5DA81"

            border.color: "#F2F5A9"
            border.width: 1

            Text{
                id:textItemrow
                anchors.fill: parent
            }
        }
    }

}


