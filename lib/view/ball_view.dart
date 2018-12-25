import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/model/ball.dart';

class RunBallView extends CustomPainter {
  Paint mPint;
  BuildContext context;
  Ball _ball;
  Rect _limit;

  RunBallView(this.context, Ball ball, Rect limit) {
    mPint = new Paint();
    _ball = ball;
    _limit = limit;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(160, 320);
    mPint.color = Color.fromARGB(148, 198, 246, 248);
    canvas.drawRect(_limit, mPint);

    canvas.save();
    drawBall(canvas, _ball);
    canvas.restore();
  }

  void drawBall(Canvas canvas, Ball ball) {
    mPint.color = ball.color;
    canvas.drawCircle(new Offset(ball.x, ball.y), ball.r, mPint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
