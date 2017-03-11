import QtQuick 2.0

Rectangle {
    id: hospitals
    property alias model: model
    signal selected(string hospid)

    color: 'white'
    ListView {
        anchors.centerIn: parent
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        width: 400
        height: parent.height

        spacing: 10

        model: ListModel {
            id: model
        }
        delegate: Rectangle {
            height : 60
            width: parent.width
            radius: 15.0
            border.color: 'black'
            color: 'aliceblue'
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                }
                elide: Text.ElideRight
                font.pixelSize: 20
                text: name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: hospitals.selected(id)
            }
        }

    }
}
