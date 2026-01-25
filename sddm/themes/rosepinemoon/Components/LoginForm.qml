import QtQuick 6
import QtQuick.Controls 6
import QtQuick.Effects 6
// import SddmComponents 6 as SDDM

Rectangle {
    id: loginForm
    width: parent.width * 0.95
    anchors.horizontalCenter: parent.horizontalCenter

    radius: height / 2

    color: config.FormBackgroundColor
    border.color: config.LoginFormBorderColor
    border.width: config.BorderWidth

    property Item userSelect
    property Item sessionSelect
    property string fontRegular

    Image {
        id: lockIcon

        source: "../Images/lockIcon.png"

        height: parent.height * 0.5 - config.BorderWidth
        width: height

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: height
        visible: false
    }
    MultiEffect {
        source: lockIcon
        anchors.fill: lockIcon
        colorization: 1.0
        colorizationColor: config.LoginTextColor
    }

    TextInput {
        id: textInput

        anchors.left: lockIcon.right
        anchors.leftMargin: parent.width * 0.01
        anchors.right: submitButton.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        // anchors.verticalCenter: parent.verticalCenter

        verticalAlignment: TextInput.AlignVCenter

        font.pointSize: height
        font.family: fontLoaderBold.name

        color: config.LoginTextColor

        cursorDelegate: Rectangle {
            id: cursor
            width: 2
            height: parent.height / 2
            anchors.verticalCenter: parent.verticalCenter
            color: config.LoginTextColor

            // Qml normally overwrites cursor delegate height
            // so this chucks it back to what we want whenever
            // it tries to change it
            onHeightChanged: height = parent.height / 2

            states: [
                State {
                    name: "blinking"
                    when: isBlinking
                }
            ]

            transitions: [
                Transition {
                    from: ""
                    to: "blinking"
                    SequentialAnimation {
                        loops: Animation.Infinite
                        PropertyAnimation { target: cursor; property: "opacity"; from: 1.0; to: 0.0; duration: 800 }
                        PropertyAnimation { target: cursor; property: "opacity"; from: 0.0; to: 1.0; duration: 800 }
                    }
                }
            ]

            property bool isBlinking: true
        }

        echoMode: TextInput.Password

        Component.onCompleted: {
            textInput.forceActiveFocus()
        }

        function login() {
            let user = userSelect.currentText
            let sessionIndex = sessionSelect.currentIndex
            let password = textInput.text

            sddm.login(user, password, sessionIndex)

            console.log("Logging in...")
        }

        onAccepted: {
            if (config.boolValue("DebugMode")) {
                sddm.loginFailed()
            } 
            
            textInput.login()
        }
    }

    Text {
        anchors.fill: textInput
        anchors.rightMargin: config.intValue("Unit") / 4

        text: "Caps Lock Enabled"

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: config.DimTextColor

        font.family: fontRegular

        visible: config.boolValue("DebugMode") ? true : keyboard.capsLock
    }

    Button {
        id: submitButton

        height: parent.height * 0.75 - config.BorderWidth
        width: height

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.height * 0.2 + config.BorderWidth

        flat: true
        display: AbstractButton.IconOnly

        hoverEnabled: true

        background: Rectangle {
            opacity: submitButton.hovered ? 0.3 : 0.0
            anchors.horizontalCenter: submitButton.horizontalCenter
            height: submitButton.height
            width: height
            radius: width / 2
        }

        icon.cache: false
        icon.source: "../Images/returnIcon.png"
        icon.color: config.LoginTextColor

        onClicked: {
            if (config.boolValue("DebugMode")) {
                sddm.loginFailed()
            } else {
                textInput.login()
            }
        }
    }
}
