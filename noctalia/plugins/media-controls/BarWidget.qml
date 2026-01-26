import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.Media
import qs.Services.UI
import qs.Widgets
import qs.Widgets.AudioSpectrum

Rectangle {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    // Media Player Stuff
    readonly property bool hasPlayer: MediaService.currentPlayer !== null
    readonly property int artSize: Style.barHeight
    readonly property int maxTextWidth: 300
    // CavaService Registration for visualizer
    readonly property string cavaComponentId: "bar:media-controls:" + root.screen?.name + ":" + root.section + ":" + root.sectionWidgetIndex
    readonly property bool needsCava: true

    opacity: hasPlayer ? 1.0 : 0.0

    onNeedsCavaChanged: {
        if (root.needsCava) {
            CavaService.registerComponent(root.cavaComponentId);
        } else {
            CavaService.unregisterComponent(root.cavaComponentId);
        }
    }

    Component.onDestruction: {
        if (root.needsCava) {
            CavaService.unregisterComponent(root.cavaComponentId);
        }
    }

    implicitWidth: row.implicitWidth + Style.marginM * 2
    implicitHeight: Style.barHeight
    color: Style.capsuleColor
    radius: Style.radiusM

    // Visualizer
    NLinearSpectrum {
        width: parent.implicitWidth - Style.marginS
        height: 20
        anchors.horizontalCenter: parent.horizontalCenter
        values: CavaService.values
        fillColor: Color.mPrimary
        opacity: 0.4
        barPosition: "center"
    }

    RowLayout {
        id: buttonsRow

        anchors.centerIn: parent
        spacing: Style.marginM

        width: parent.implicitWidth

        z: 5

        Item {
            Layout.preferredWidth: root.implicitWidth * 0.2 - Style.marginM
            Layout.preferredHeight: Style.barHeight

            MouseArea {
                anchors.fill: parent
                cursorShape: hasPlayer ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: MediaService.previous()
            }
        }

        Item {
            Layout.preferredWidth: root.implicitWidth * 0.6
            Layout.preferredHeight: Style.barHeight

            MouseArea {
                anchors.fill: parent
                cursorShape: hasPlayer ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: MediaService.playPause()
            }
        }

        Item {
            Layout.preferredWidth: root.implicitWidth * 0.2 - Style.marginM
            Layout.preferredHeight: Style.barHeight

            MouseArea {
                anchors.fill: parent
                cursorShape: hasPlayer ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: MediaService.next()
            }
        }
    }

    RowLayout {
        id: row

        anchors.centerIn: parent
        spacing: Style.marginS
        // NIconButton {
        //     id: prevButton
        //     icon: "player-skip-back"
        //     colorBorder: "#00000000"
        //     onClicked: {
        //         MediaService.previous()
        //     }
        // }

        Item {
            Layout.preferredWidth: artSize
            Layout.preferredHeight: artSize

            ProgressRing {
                anchors.fill: parent
                progress: MediaService.trackLength > 0 ? MediaService.currentPosition / MediaService.trackLength : 0
                z: 1
            }

            NImageRounded {
                anchors.fill: parent
                anchors.margins: 2
                visible: true
                radius: width / 2
                imagePath: MediaService.trackArtUrl
                borderWidth: 0
                imageFillMode: Image.PreserveAspectCrop
            }

        }

        NScrollText {
            id: titleContainer
            Layout.preferredWidth: Math.min(maxTextWidth, measuredWidth)
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: capsuleHeight

            maxWidth: Math.min(maxTextWidth, measuredWidth)

            text: {
                if (!hasPlayer)
                    return I18n.tr("bar.media-mini.no-active-player");
                var artist = MediaService.trackArtist;
                var track = MediaService.trackTitle;
                // return track
                return (artist ? `${track} - ${artist}` : track);
            }

            scrollMode: NScrollText.ScrollMode.Hover
        }

        // NIconButton {
        //     id: nextButton
        //     icon: "player-skip-forward"
        //     colorBorder: "#00000000"
        //     onClicked: {
        //         MediaService.next()
        //     }
        // }
    }

    Behavior on opacity {
    NumberAnimation {
      duration: Style.animationNormal
      easing.type: Easing.InOutCubic
    }
    }
    Behavior on implicitWidth {
        NumberAnimation {
        duration: Style.animationNormal
        easing.type: Easing.InOutCubic
        }
    }
    Behavior on implicitHeight {
        NumberAnimation {
        duration: Style.animationNormal
        easing.type: Easing.InOutCubic
        }
    }

    component ProgressRing: Canvas {
        property real progress: 0
        property real lineWidth: 2

        onProgressChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onPaint: {
            if (width <= 0 || height <= 0)
                return ;

            var ctx = getContext("2d");
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - lineWidth;
            ctx.reset();
            // Background
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = Qt.alpha(Color.mOnSurface, 0.4);
            ctx.stroke();
            // Progress
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, -Math.PI / 2, -Math.PI / 2 + progress * 2 * Math.PI);
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = Color.mPrimary;
            ctx.lineCap = "round";
            ctx.stroke();
        }

        Connections {
            function onMPrimaryChanged() {
                requestPaint();
            }

            target: Color
        }

    }

}
