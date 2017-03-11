import QtQuick 2.0

ListView {
    spacing: 10

    delegate: Rectangle {
        height : 60
        width: parent.width
        radius: 15.0
        border.color: 'black'
        color: 'aliceblue'
        clip: true
        Text {
            anchors {
                left: parent.left
                leftMargin: 10
                top: parent.top
                topMargin: 3
            }
            font.pixelSize: 10
            text: /*{
                return Math.floor(time / 1000)
                var d = new Date)
                return d.getFullYear();
            }
            */
                Qt.formatDateTime(new Date(Math.floor(time / 1000)), 'hh:mm dd.MM.yy')
        }
        Text {
            anchors {
                left: parent.left
                leftMargin: 10
                top: parent.top
                topMargin: 20
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin:3
            }
            wrapMode: Text.WordWrap
            //elide: Text.ElideRight
            font.pixelSize: 8
            text: txt
            //var formatted = t.format("dd.mm.yyyy hh:MM:ss");Qt.formatDateTime time
        }
    }

}
