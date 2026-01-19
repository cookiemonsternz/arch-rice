import QtQuick 2.0
import QtQuick.Controls

ComboBox {
    id: userSelect

    required property string fontRegular
    required property string fontBold

    font.family: fontRegular

    model: userModel
    currentIndex: userModel.lastIndex

    textRole: "name"
    displayText: "User: " + currentText

    delegate: ItemDelegate {
        id: delegate

        required property string name

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        contentItem: Text {
            id: delegateText
            text: ""
            color: hovered ? config.MainTextColor : config.DimTextColor
            font: userSelect.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        text: name
        width: userSelect.width

        onNameChanged: {
            function capitalizeFirstLetter([ first='', ...rest ], locale) {
                return [ first.toLocaleUpperCase(locale), ...rest ].join('');
            }

            delegateText.text = capitalizeFirstLetter(delegate.name, config.Locale)
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: userSelect.indicator.width + userSelect.spacing

        text: userSelect.displayText
        font: userSelect.font
        color: config.MainTextColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: userSelect
        color: "transparent"
        border.color: "transparent"
    }

    popup: Popup {
        y: userSelect.height - 1
        width: userSelect.width
        height: Math.min(userSelect.implicitHeight, userSelect.Window.height - topMargin - bottomMargin)
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: userSelect.popup.visible ? userSelect.delegateModel : null
            currentIndex: userSelect.highlightedIndex

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
        x: userSelect.width - width - userSelect.rightPadding
        y: userSelect.topPadding + (userSelect.availableHeight - height) / 2
        width: 10
        height: 6
        contextType: "2d"

        Connections {
            target: userSelect
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = userSelect.pressed ? config.DimTextColor : config.MainTextColor;
            context.fill();
        }
    }
}