import QtQuick 2.5
import QtQuick.Window 2.2
import QtWebView 1.1
import 'api.js' as API

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr('QMLJSONTest')


    ListModel {
        id: messages
        onCountChanged: console.log('messages ', count)
    }

    MessageList {
        id: messageList
        width: 200
        model: messages
        anchors {
            top: parent.top
            topMargin: 80
            right: parent.right
            bottom: parent.bottom
        }
    }

    Login {
        id: login
        anchors {
            top: parent.top
            topMargin: 80
            left: parent.left
            bottom: parent.bottom
            right: messageList.left
        }
        visible: true
        onStartLogin: {
            visible = false
            API.login(hospitals.model, login, password)
        }
    }

    Button {
        id: logout
        width: 200
        height: 40
        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 10
        }
        text: qsTr('Logout')
        visible: false
        onClick: {
            getMessagesTimer.stop()
            API.logout()
        }
    }
/*
    Rectangle {
        x :0
        y: 0
        height : 40
        width: 40
        color: webview.loading ? 'red' : 'green'
    }

    Button {
        width: 200
        height: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: 'test'
        onClick: {
            webview.runJavaScript("sessionStorage.getItem('MGWA-userToken')", function(result) { console.log(result); });
            webview.runJavaScript("sessionStorage.getItem('MGWA-userHospitalId')", function(result) { console.log(result); });
            webview.runJavaScript("sessionStorage.getItem('MGWA-userData')", function(result) { console.log(result); });
        }
    }
*/

    WebView {
        id: webview
        anchors {
            top: parent.top
            topMargin: 80
            left: parent.left
            bottom: parent.bottom
            right: messageList.left
        }
        visible: false
        z: 10
    }

    Hospitals {
        id: hospitals
        anchors {
            top: parent.top
            topMargin: 80
            left: parent.left
            bottom: parent.bottom
            right: messageList.left
        }
        visible: false
        onSelected: API.loginSetHospital(hospid)
    }

    ErrorPanel {
        id: errorPanel
        x : 0
        y : 0
    }

    Timer {
        id: getMessagesTimer
        running: false
        interval: 1000 * 10
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            API.messageGetNew(messages)
        }
    }

    function loginWebApp() {
        webview.runJavaScript("sessionStorage.setItem('item', '%1')".arg(API.ACCESS_TOKEN), function(result) { console.log(result); });
        webview.url = API.WEBAPP_HOST
        webview.visible = true
    }

    Component.onCompleted: {
        API.onLogin = function() {
            login.visible = false
            hospitals.visible = true
        }
        API.onLoginError = function(e) {
            errorPanel.open(e)
            login.visible = true
            hospitals.visible = false
        }
        API.onLoginSetHospital = function() {
            //login.visible = false
            hospitals.visible = false
            logout.visible = true
            getMessagesTimer.start()
            loginWebApp()
        }
        API.onLogout = function() {
            webview.visible = false
            logout.visible = false
            login.visible = true
        }
        API.onReqError = function(e) {
            errorPanel.open(e)
        }
        webview.url = API.WEBAPP_HOST
    }
}
