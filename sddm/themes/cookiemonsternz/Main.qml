import QtQuick 2.0
import SddmComponents 2.0
import QtMultimedia

Rectangle {
    id : cookiemonsternz_root

    // // Colors
    // property color primaryShade : config.primaryShade ? config.primaryShade : '#232136'
    // property color primaryLight : config.primaryLight ? config.primaryLight : '#4e4a70'
    // property color primaryDark  : config.primaryDark  ? config.primaryDark  : '#131223'

    // property color primaryHue1  : config.primaryHue1  ? config.primaryHue1  : "#3e8fb0"
    // property color primaryHue2  : config.primaryHue2  ? config.primaryHue2  : '#2e6b84'
    // property color primaryHue3  : config.primaryHue3  ? config.primaryHue3  : '#204f61'

    // property color accentShade  : config.accentShade  ? config.accentShade  : "#eb6f92"
    // property color accentLight  : config.accentLight  ? config.accentLight  : "#ea9a97"

    // property color accentHue1   : config.accentHue1   ? config.accentHue1   : "#ea9a97"
    // property color accentHue2   : config.accentHue2   ? config.accentHue2   : '#df7c79'
    // property color accentHue3   : config.accentHue3   ? config.accentHue3   : '#be5450'

    // property color normalText   : config.normalText   ? config.normalText   : "#e0def4"

    // property color successText  : config.successText  ? config.successText  : "#43a047"
    // property color failureText  : config.failureText  ? config.failureText  : "#e53935"
    // property color warningText  : config.warningText  ? config.warningText  : "#ff8f00"

    // property color rebootColor  : config.rebootColor  ? config.rebootColor  : "#fb8c00"
    // property color powerColor   : config.powerColor   ? config.powerColor   : "#ff1744"

    // readonly property color defaultBg : primaryShade ? primaryShade : "#1e88e5"

    // //
    // // Indicates one unit of measure (in pixels)
    // //
    // readonly property int spUnit: 64

    // //
    // // Symmetric (equal) padding on all sides
    // //
    // readonly property int padSym : (spUnit / 8)

    // //
    // // Asymmetric padding in horizontal & vertical directions
    // //
    // readonly property int padAsymH : (spUnit / 2)
    // readonly property int padAsymV : (spUnit / 8)

    // //
    // // Font sizes
    // //
    // readonly property int spFontNormal  : 24
    // readonly property int spFontSmall   : 16

    // TextConstants { id: textConstants }

    // color: "red"

    MediaPlayer {
        id: player

        source: "/usr/share/sddm/themes/cookiemonsternz/Images/bg-video.webm"

        autoPlay: true

        videoOutput: videoOutput
        playbackRate: 0.5
        loops: -1
    }

    VideoOutput {
        id: videoOutput

        fillMode: VideoOutput.PreserveAspectFit
        anchors.fill: parent
    }
}