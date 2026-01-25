import QtQuick 6
import QtQuick.Controls 6
import QtQuick.Effects 6
import QtQuick.Layouts 6
// import SddmComponents 6 as SDDM

RowLayout {
    id: powerButtons
    required property string fontRegular
    required property string fontBold

    spacing: width * 0.02
    uniformCellSizes: true
    Button {
        id: hibernateButton

        visible: sddm.canHibernate || config.boolValue("DebugMode")

        Layout.fillWidth: true
        Layout.fillHeight: true
        // width: (parent.width / numElements) - (((numElements - 1) * parent.spacing) / numElements)
        // height: parent.height

        text: "Hibernate"
        font.family: fontRegular
        font.pixelSize: height / 4

        palette.buttonText: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        icon.source: "../Images/hibernateIcon.png"
        icon.color: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        background: Rectangle {
            anchors.fill: parent
            radius: height / 2.5

            color: parent.hovered ? config.PowerButtonsHoverColor : "transparent"

            border.color: parent.hovered ? config.PowerButtonsHoverColor : config.PowerButtonsBorderColor
            border.width: config.PowerButtonsBorderWidth
        }

        // Component.onCompleted: {
        //     if (config.boolValue("DebugMode")) {
        //         return
        //     }
            
        //     if (!sddm.canHibernate) {
        //         hibernateButton.visible = false
        //         powerButtons.numElements -= 1
        //     }
        // }

        onClicked: {
            console.log("Hibernating...")
            sddm.hibernate()
        }
    }
    Button {
        id: suspendButton

        visible: sddm.canSuspend || config.boolValue("DebugMode")

        Layout.fillWidth: true
        Layout.fillHeight: true
        // width: (parent.width / numElements) - (((numElements - 1) * parent.spacing) / numElements)
        // height: parent.height

        text: "Suspend"
        font.family: fontRegular
        font.pixelSize: height / 4

        palette.buttonText: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        icon.source: "../Images/suspendIcon.png"
        icon.color: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        background: Rectangle {
            anchors.fill: parent
            radius: height / 2.5

            color: parent.hovered ? config.PowerButtonsHoverColor : "transparent"

            border.color: parent.hovered ? config.PowerButtonsHoverColor : config.PowerButtonsBorderColor
            border.width: config.PowerButtonsBorderWidth
        }

        // Component.onCompleted: {
        //     if (config.boolValue("DebugMode")) {
        //         return
        //     }

        //     if (!sddm.canSuspend) {
        //         suspendButton.visible = false
        //         powerButtons.numElements -= 1
        //     }
        // }

        onClicked: {
            console.log("Suspending...")
            sddm.suspend()
        }
    }
    Button {
        id: rebootButton

        visible: sddm.canReboot || config.boolValue("DebugMode")

        Layout.fillWidth: true
        Layout.fillHeight: true
        // width: (parent.width / numElements) - (((numElements - 1) * parent.spacing) / numElements)
        // height: parent.height

        text: "Reboot"
        font.family: fontRegular
        font.pixelSize: height / 4

        palette.buttonText: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        icon.source: "../Images/rebootIcon.png"
        icon.color: hovered ? config.PowerButtonsTextColorHovered : config.PowerButtonsTextColor

        background: Rectangle {
            anchors.fill: parent
            radius: height / 2.5

            color: parent.hovered ? config.PowerButtonsHoverColor : "transparent"

            border.color: parent.hovered ? config.PowerButtonsHoverColor : config.PowerButtonsBorderColor
            border.width: config.PowerButtonsBorderWidth
        }

        // Component.onCompleted: {
        //     if (config.boolValue("DebugMode")) {
        //         return
        //     }

        //     if (!sddm.canReboot) {
        //         rebootButton.visible = false
        //         powerButtons.numElements -= 1
        //     }
        // }

        onClicked: {
            console.log("Rebooting...")
            sddm.reboot()
        }
    }
    Button {
        id: shutdownButton

        visible: sddm.canPowerOff || config.boolValue("DebugMode")

        Layout.fillWidth: true
        Layout.fillHeight: true
        // width: (parent.width / numElements) - (((numElements - 1) * parent.spacing) / numElements)
        // height: parent.height

        text: "Shutdown"
        font.family: fontRegular
        font.pixelSize: height / 4

        palette.buttonText: hovered ? config.PowerButtonsTextColorHovered : config.ShutdownTextColor

        icon.source: "../Images/shutdownIcon.png"
        icon.color: hovered ? config.PowerButtonsTextColorHovered : config.ShutdownTextColor

        background: Rectangle {
            anchors.fill: parent
            radius: height / 2.5

            color: parent.hovered ? config.ShutdownTextColor : "transparent"

            border.color: config.ShutdownTextColor
            border.width: config.PowerButtonsBorderWidth
        }

        // Component.onCompleted: {
        //     if (config.boolValue("DebugMode")) {
        //         return
        //     }

        //     if (!sddm.canPowerOff) {
        //         shutdownButton.visible = false
        //         powerButtons.numElements -= 1
        //     }
        // }

        onClicked: {
            console.log("Shutting down...")
            sddm.powerOff()
        }
    }
}