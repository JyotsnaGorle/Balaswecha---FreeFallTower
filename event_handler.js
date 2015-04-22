.pragma library
Qt.include("properties.js")

function onBallClicked(scale, ballId) {
    scale.ball.source = source(ballId)
    scale.ball.visible = true;
    scale.ball.text = text(ballId);
    scale.ballText = scale.ball.text;
}
var status
function dropover()
{
    if (status==="stopped")
        return true
}




