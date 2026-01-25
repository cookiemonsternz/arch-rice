import QtQuick 6
import QtQuick.Controls 6

ComboBox {
    id: sessionSelect

    required property string fontRegular
    required property string fontBold

    font.family: fontRegular

    model: sessionModel
    currentIndex: sessionModel.lastIndex

    textRole: "name"
    displayText: "Session: "

    delegate: ItemDelegate {
        id: delegate

        required property string name

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        contentItem: Text {
            text: delegate.name
            color: hovered ? config.MainTextColor : config.DimTextColor
            font: sessionSelect.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        text: name
        width: sessionSelect.width
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: sessionSelect.indicator.width + sessionSelect.spacing

        text: sessionSelect.displayText
        font: sessionSelect.font
        color: config.MainTextColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: sessionSelect
        color: "transparent"
        border.color: "transparent"
    }

    popup: Popup {
        y: sessionSelect.height - 1
        width: sessionSelect.width
        // height: sessionSelect.height
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: sessionSelect.popup.visible ? sessionSelect.delegateModel : null
            currentIndex: sessionSelect.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: config.GrayBorderColor
            color: config.FormBackgroundColor
            radius: 2
        }
    }

    indicator: Canvas {
        id: canvas
        x: sessionSelect.width - width - sessionSelect.rightPadding
        y: sessionSelect.topPadding + (sessionSelect.availableHeight - height) / 2
        width: 10
        height: 6
        contextType: "2d"

        Connections {
            target: sessionSelect
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = sessionSelect.pressed ? config.DimTextColor : config.MainTextColor;
            context.fill();
        }
    }
}