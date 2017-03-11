import QtQuick 2.0

Rectangle {
    id: login
    signal startLogin(string login, string password)

    color: 'white'


    Column {
        anchors.centerIn: parent
        spacing: 10
        Editor {
            id: account
            width: 320
            height: 40
            text: ''
        }
        Editor {
            id: password
            width: 320
            height: 40
            password: true
            text: ''
        }
        Button {
            width: 200
            height: 40
            text: qsTr('Login')
            enabled: account.text !== ''
            onClick: {
                login.startLogin(account.text, password.text)
            }
        }
    }
}
