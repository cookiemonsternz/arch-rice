import QtQuick 6
import QtQuick.Controls 6
import QtQuick.Effects 6
import QtQml 6

Rectangle {
    id: failureToast

    required property string fontRegular
    property bool hidden: true
    required property real hiddenY

    color: config.ShutdownTextColor

    radius: config.SectionRadius
    width: failureToastText.contentWidth + config.Unit / 2

    function toast(dur) {
        if (!timer.running) {
            failureToast.hidden = false
            timer.interval = dur
            timer.start()
        } else {
            timer.stop()
            timer.interval = dur
            timer.start()
        }
    }

    Label {
        id: failureToastText

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: "Login Failed"

        color: config.PowerButtonsTextColorHovered

        font.family: fontRegular
    }

    Timer {
        id: timer

        repeat: false
        interval: 1000

        onTriggered: {
            failureToast.hidden = true
        }
    }

    states: State {
        name: "moved"; when: !failureToast.hidden
        PropertyChanges { target: failureToast; x: 0; y: failureToast.hiddenY-config.intValue("Unit") / 2 }
    }

    transitions: Transition {
        NumberAnimation { properties: "x,y"; easing.type: Easing.InOutExpo }
    }
}