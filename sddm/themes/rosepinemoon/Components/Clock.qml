import QtQuick 2.0
import QtQuick.Controls 2.0


Rectangle {
    id: clock

    height: parent.height * 0.65
    width: clock.height

    radius: 180

    color: "transparent"
    // border.width: config.BorderWidth
    // border.color: "pink"

    Label {
        id: hourLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height / 10

        color: config.ClockTextColor
        font.pointSize: parent.height / 4
        font.bold: true
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), "hh")
        }
    }
    
    Label {
        id: minuteLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10

        color: config.ClockTextColor
        font.pointSize: parent.height / 4
        font.bold: true
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), "mm")
        }
    }

    Circle {
        id: secondCircle
        size: parent.height
        value: 0
        strokeWidth: config.ClockBorderWidth
        primaryColor: config.ClockBorderColorBright
        secondaryColor: config.ClockBorderColorDim

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        z: -1

        function updateTime() {
            value = parseFloat(new Date().toLocaleTimeString(Qt.locale(), "ss")) / 60
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            hourLabel.updateTime()
            minuteLabel.updateTime()
            secondCircle.updateTime()
        }
    }

    Component.onCompleted: {
        hourLabel.updateTime()
        minuteLabel.updateTime()
        secondCircle.updateTime()
    }
}