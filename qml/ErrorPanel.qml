import QtQuick 2.0

Rectangle {
    id: error
    width: 600
    height: 80
    radius: 15.0
    border.color: 'black'
    color: 'lightcoral'
    z: 100
    visible: false

    function open(text) {
        label.text = text
        visible = true
        timer.start()
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: 'black'
    }

    Timer {
        id: timer
        running: false
        interval: 1000 * 5
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            error.visible = false
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent

        onClicked: {

        }
    }
}
