import QtQuick 2.0

Rectangle {
    id: editor
    property alias text: edit.text
    property bool password: false

    radius: 15.0
    border.color: 'black'
    color: 'transparent'
    TextInput {
        id: edit
        anchors.centerIn: parent
        width: parent.width - 20
        //height: parent.height - 4
        selectByMouse: true
        color: 'black'
        //fontSizeMode: Text.Fit
        font {
            pixelSize: 16
            family: 'Helvetica'
        }
        focus: true
        echoMode: editor.password ? TextInput.Password : TextInput.Normal
    }
}
