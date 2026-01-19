import QtQuick 2.0
import QtQuick.Controls 2.0
import SddmComponents 2.0
import QtMultimedia
import QtQuick.Effects
import QtQuick.Controls.Fusion

import "Components"

Pane {
    FontLoader {
        id: fontLoader
        source: config.FontURL
    }

    FontLoader {
        id: fontLoaderBold
        source: config.BoldFontURL
    }

    id : root

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.ScreenWidth
    padding: config.ScreenPadding

    font.family: config.Font !== "" ? config.Font : fontLoader.name
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80) || 13

    //
    // Symmetric (equal) padding on all sides
    //
    readonly property int padSym : (config.Unit / 8)

    //
    // Asymmetric padding in horizontal & vertical directions
    //
    readonly property int padAsymH : (config.Unit / 2)
    readonly property int padAsymV : (config.Unit / 8)

    //
    // Font sizes
    //
    // readonly property int spFontNormal  : 24
    // readonly property int spFontSmall   : 16

    // TextConstants { id: textConstants }

    Rectangle {
        id: greetingBar

        width: parent.width / 4.5
        height: parent.height / 12

        anchors.top: parent.top
        anchors.topMargin: config.Unit
        anchors.horizontalCenter: parent.horizontalCenter

        color: config.GreetingBarBackgroundColor

        radius: config.SectionRadius

        border.width: 0.5
        border.color: config.GrayBorderColor

        Profile {
            id: profile

            anchors.left: parent.left
            anchors.leftMargin: parent.height * 0.25
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: greetingText

            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.25
            anchors.left: profile.right
            anchors.leftMargin: parent.width * 0.05
            anchors.right: clock.left
            anchors.rightMargin: parent.width * 0.05

            font.pointSize: 100
            fontSizeMode: Text.HorizontalFit
            textFormat: Text.PlainText
            font.family: fontLoader.name
            color: config.MainTextColor

            maximumLineCount: 1
            elide: Text.ElideRight

            minimumPointSize: parent.height / 7

            z:1

            Component.onCompleted: {
                function capitalizeFirstLetter([ first='', ...rest ], locale) {
                    return [ first.toLocaleUpperCase(locale), ...rest ].join('');
                }

                text = "Welcome back, " + capitalizeFirstLetter(userSelect.currentText, config.Locale) + "!"
            }
        }

        Label {
            id: dateText
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.25
            anchors.left: profile.right
            anchors.leftMargin: parent.width * 0.05

            font.pointSize: parent.height / 8
            color: config.DimTextColor
            
            Component.onCompleted: {
                text = new Date().toLocaleDateString(Qt.locale(), "dddd, MMMM dd")
            }
        }

        Clock {
            id: clock

            anchors.right: parent.right
            anchors.rightMargin: parent.height * 0.175
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    RectangularShadow {
        id: greetingBarShadow
        anchors.fill: greetingBar
        offset.x: config.DropShadowOffsetX
        offset.y: config.DropShadowOffsetY
        radius: greetingBar.radius
        blur: config.DropShadowBlur
        spread: config.DropShadowSpread
        color: Qt.alpha(Qt.lighter(greetingBar.color, config.DropShadowBrightness), config.DropShadowTransparency)

        z: -1
    }

    Rectangle {
        id: loginBar
        width: parent.width / 3
        height: parent.height / 11

        anchors.bottom: parent.bottom
        anchors.bottomMargin: config.Unit
        anchors.horizontalCenter: parent.horizontalCenter

        color: config.LoginBarBackgroundColor

        radius: config.SectionRadius

        border.width: 0.5
        border.color: config.GrayBorderColor

        LoginForm {
            userSelect: userSelect
            sessionSelect: sessionSelect
            fontRegular: fontLoader.name

            height: parent.height * 0.3

            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
        }

        PowerButtons {
            height: parent.height * 0.4
            width: parent.width * 0.95
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter

            fontRegular: fontLoader.name
            fontBold: fontLoaderBold.name
        }
    }
    RectangularShadow {
        id: loginBarShadow
        anchors.fill: loginBar
        offset.x: config.DropShadowOffsetX
        offset.y: config.DropShadowOffsetY
        radius: greetingBar.radius
        blur: config.DropShadowBlur
        spread: config.DropShadowSpread
        color: Qt.alpha(Qt.lighter(loginBar.color, config.DropShadowBrightness), config.DropShadowTransparency)

        z: -1
    }

    Rectangle {
        id: selectionPanel

        anchors.top: greetingBar.bottom
        anchors.topMargin: config.Unit / 2
        anchors.horizontalCenter: greetingBar.horizontalCenter

        width: parent.width / 5
        height: parent.height / 32

        color: config.GreetingBarBackgroundColor

        radius: config.SectionRadius

        border.width: 0.5
        border.color: config.GrayBorderColor

        Row {
            anchors.fill: parent
            anchors.leftMargin: parent.width * 0.05
            anchors.rightMargin: parent.width * 0.05

            spacing: parent.width * 0.05

            SessionSelect {
                id: sessionSelect

                fontRegular: fontLoader.name
                fontBold: fontLoaderBold.name

                width: (parent.width / 2) - parent.spacing * 3 / 2
                height: parent.height

                onActivated: {
                    function capitalizeFirstLetter([ first='', ...rest ], locale) {
                        return [ first.toLocaleUpperCase(locale), ...rest ].join('');
                    }

                    sessionSelect.displayText = "Session: " + capitalizeFirstLetter(sessionSelect.currentText, config.Locale)
                }

                Component.onCompleted: {
                    function capitalizeFirstLetter([ first='', ...rest ], locale) {
                        return [ first.toLocaleUpperCase(locale), ...rest ].join('');
                    }

                    sessionSelect.displayText = "Session: " + capitalizeFirstLetter(sessionSelect.currentText, config.Locale)
                }
            }

            Rectangle {
                width: 1
                height: parent.height

                color: config.GrayBorderColor
            }

            UserSelect {
                id: userSelect

                fontRegular: fontLoader.name
                fontBold: fontLoaderBold.name

                width: (parent.width / 2) - parent.spacing * 3 / 2
                height: parent.height

                onActivated: {
                    function capitalizeFirstLetter([ first='', ...rest ], locale) {
                        return [ first.toLocaleUpperCase(locale), ...rest ].join('');
                    }

                    greetingText.text = "Welcome back, " + capitalizeFirstLetter(userSelect.currentText, config.Locale) + "!"
                    userSelect.displayText = "User: " + capitalizeFirstLetter(userSelect.currentText, config.Locale)
                }

                Component.onCompleted: {
                    function capitalizeFirstLetter([ first='', ...rest ], locale) {
                        return [ first.toLocaleUpperCase(locale), ...rest ].join('');
                    }

                    userSelect.displayText = "User: " + capitalizeFirstLetter(userSelect.currentText, config.Locale)
                }
            }
        }
    }
    RectangularShadow {
        id: selectionPanelShadow
        anchors.fill: selectionPanel
        offset.x: config.DropShadowOffsetX
        offset.y: config.DropShadowOffsetY
        radius: selectionPanel.radius
        blur: config.DropShadowBlur
        spread: config.DropShadowSpread
        color: Qt.alpha(Qt.lighter(selectionPanel.color, config.DropShadowBrightness), config.DropShadowTransparency)

        z: -1
    }

    FailureToast {
        id: failureToast

        height: parent.height / 64

        y: loginBar.y
        hiddenY: loginBar.y
        anchors.horizontalCenter: parent.horizontalCenter

        fontRegular: fontLoader.name

        z: -1
    }

    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            failureToast.toast(3000)
        }
    }

    MediaPlayer {
        id: playerForwards

        source: config.BackgroundURLForwards

        videoOutput: videoOutputForwards
        playbackRate: 2.0
        loops: 1

        autoPlay: true

        onPositionChanged: {
            if (playerForwards.position > 1000 && playerForwards.duration - playerForwards.position < 3000 && playerReverse.playing == false) {
                playerReverse.play()
            }

            if (playerForwards.position > 1000 && playerForwards.duration - playerForwards.position < 500) {
                videoOutputForwards.visible = false
                videoOutputReverse.visible = true

                playerForwards.stop()
            }
        }
    }

    MediaPlayer {
        id: playerReverse

        source: config.BackgroundURLReverse

        autoPlay: false

        videoOutput: videoOutputReverse
        playbackRate: 2.0
        loops: 1

        onPositionChanged: {
            if (playerReverse.position > 1000 && playerReverse.duration - playerReverse.position < 1000 && playerForwards.playing == false) {
                playerForwards.play()
            }

            if (playerReverse.position > 1000 && playerReverse.duration - playerReverse.position < 250) {
                videoOutputForwards.visible = true
                videoOutputReverse.visible = false

                playerReverse.stop()
            }
        }
    }

    VideoOutput {
        id: videoOutputForwards

        fillMode: VideoOutput.PreserveAspectFit
        anchors.fill: parent

        visible: true

        z: -5
    }

    VideoOutput {
        id: videoOutputReverse

        fillMode: VideoOutput.PreserveAspectFit
        anchors.fill: parent

        visible: false

        z: -5
    }
}