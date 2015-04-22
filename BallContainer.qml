import QtQuick 2.0

Rectangle{
    id: root
    color: "#49BAB6"
    property int duration: 0
    property string medium
    property alias ball: ball
    property alias ballWeight : ball.weight
    property alias ballSource : ball.source
    property alias ballVisible : ball.visible
    property int n:(ball.weight-100)/50
    property int s:5*root.n
    signal clicked;

    Ball {
        id: ball
        weight: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            root.clicked();
        }

        Behavior on y{
            NumberAnimation{
                id:animationY
                duration: root.duration;
                easing.type: Easing.InOutSine
                onRunningChanged:
                    if(animationY.running==false)
                    {
                        console.log(root.s)

                        if(rect.state=="rotated" && rect1.state=="rotated" && btnDrop!==false && btnReset.visible==true)
                        {

                            if(freeFall.rightBallContainer.ball.x!==freeFall.leftBallContainer.ball.x)
                            {
                                if(ball.x==freeFall.leftBallContainer.ball.x)
                            table.append("left")
                                if(ball.x==freeFall.rightBallContainer.ball.x)
                            table.append("right")
                            }
                            else if(freeFall.rightBallContainer.ball.x==freeFall.leftBallContainer.ball.x)
                            {
                                if(ball == freeFall.leftBallContainer.ball){
                                    table.append("left")
                                    table.append("right")
                                }



                            }

                        }
                        else
                            if(root.s!==-10)
                        {
                        if(rect.state=="rotated"&&btnDrop!==false&&btnReset.visible==true&&(ball.x==53-5*root.n))
                            table.append("left")
                        else if(rect1.state=="rotated"&&btnDrop!==false&&btnReset.visible==true&&(ball.x==53-5*root.n))
                            table.append("right")
                        }
                        }

            }

        }

    }

    function reset(){
        duration = 0;
        ball.reset();
        ball.weight = 0;
    }
}
