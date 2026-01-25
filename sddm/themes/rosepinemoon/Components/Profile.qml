import QtQuick 6
import QtQuick.Effects 6


Item {
    id: profile

    height: parent.height * 0.5
    width: height

    Rectangle {
        id: border
        anchors.fill: profile

        anchors.margins: -config.BorderWidth / 2

        radius: width/2

        z: 1

        color: "transparent"
        border.color: config.BorderColor
        border.width: config.BorderWidth
    }

    Image {
        id: sourceItem
        source: config.ProfileURL
        anchors.fill: profile

        fillMode: Image.PreserveAspectCrop

        visible: false
    }

    MultiEffect {
        source: sourceItem
        anchors.fill: sourceItem
        maskEnabled: true
        maskSource: mask
    }

    Item {
        id: mask
        width: sourceItem.width
        height: sourceItem.height
        layer.enabled: true
        visible: false

        Rectangle {
            width: sourceItem.width
            height: sourceItem.height
            radius: width/2
            color: "black"
        }
    }
}

    
