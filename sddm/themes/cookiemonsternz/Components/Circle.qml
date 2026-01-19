import QtQuick 2.0

Item {
    id: root
    property int size: 150
    property real value: 0
    property real strokeWidth: 8
    property color primaryColor: "#ff6725"
    property color secondaryColor: "#52adff"
    property int animationTime: 250
    width: size + strokeWidth
    height: size + strokeWidth

    onValueChanged: c.degree = value * 360

    Canvas {
        id: c
        property real degree: 0

        anchors.fill: parent
        antialiasing: true
        onDegreeChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d");

            var x = root.width / 2;
            var y = root.height / 2;

            var radius = root.size / 2
            var startAngle = (Math.PI / 180) * 270;
            var fullAngle = (Math.PI / 180) * (270 + 360);
            var progressAngle = (Math.PI / 180) * (270 + degree);

            ctx.reset()

            ctx.lineWidth = root.strokeWidth
            ctx.lineCap = "round"

            ctx.strokeStyle = root.secondaryColor;
            ctx.beginPath();
            // ctx.moveTo(x,y);
            ctx.arc(x, y, radius, startAngle, fullAngle);
            // ctx.lineTo(x, y)
            ctx.stroke();

            ctx.strokeStyle = root.primaryColor;
            ctx.beginPath();
            // ctx.moveTo(x,y);
            ctx.arc(x, y, radius, startAngle, progressAngle);
            // ctx.lineTo(x, y)
            ctx.stroke();
        }

        Behavior on degree {
            NumberAnimation {
                duration: root.animationTime
            }
        }
    }
}