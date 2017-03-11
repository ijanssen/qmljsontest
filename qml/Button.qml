import QtQuick 2.0

Rectangle {
    property alias text: label.text
    signal click()

    radius: 15.0
    border.color: 'black'
    //antialiasing : false
    color:  area.pressed ? 'gray' : 'white'

    Text {
        id: label
        anchors.centerIn: parent
        color: area.pressed ? 'white' : 'black'
    }

    MouseArea {
        id: area
        anchors.fill: parent

        onClicked: {
            parent.click();
        }
    }
}
