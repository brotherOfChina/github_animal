import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/model/ball.dart';

class RunBallView extends CustomPainter {
  Paint mPint;
  BuildContext context;
  List<Ball> _balls;
  Rect _limit;

  RunBallView(this.context, List<Ball> balls, Rect limit) {
    mPint = new Paint();
    _balls = balls;
    _limit = limit;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(160, 320);
    mPint.color = Color.fromARGB(148, 198, 246, 248);
    canvas.drawRect(_limit, mPint);

    canvas.save();
    _balls.forEach((ball){
      drawBall(canvas, ball);
    });

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
