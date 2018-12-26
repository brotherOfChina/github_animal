import 'package:flutter/material.dart';
import 'package:flutter_animate/model/ball.dart';
import 'package:flutter_animate/view/ball_view.dart';
import 'package:flutter_animate/helper/common_path.dart';

class RunBallPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RunBallPage();
  }
}

class _RunBallPage extends State<RunBallPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  List<Ball> _balls=List<Ball>();
  var _limit = Rect.fromLTRB(-140, -100, 140, 100);

  @override
  void initState() {
    super.initState();

//    _ball =
//        Ball(x: 0, y: 0, color: Colors.blue, r: 10, vX: 2, vY: -2, aX: 0.1, aY: 0.1);
    var _ball = Ball(
        x: 0,
        y: 0,
        color: Colors.yellow,
        r: 40,
        aX: 0.05,
        aY: 0.1,
        vX: 3,
        vY: -3  );

    _balls.add(_ball);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200000));
    animationController.addListener(() {
      updateBall();
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  void updateBall() {
    for (int i = 0; i < _balls.length; i++) {
      var _ball = _balls[i];
      if (_ball.r < 0.3) {
        _balls.removeAt(i);
      }
      _ball.x += _ball.vX;
      _ball.y += _ball.vY;
      _ball.vX += _ball.aX;
      _ball.vY += _ball.aY;
      //设定下边界
      if (_ball.y > _limit.bottom - _ball.r) {
        var newBall = fromBall(_ball);
        newBall.r=newBall.r/2;
        newBall.vX = -newBall.vX;
        newBall.vY = -newBall.vY;
        _balls.add(newBall);
        _ball.y=_limit.bottom;
        _ball.r=_ball.r/2;
        _ball.vY=-_ball.vY;
        _ball.color = randomRGB();
      }
      //设定上边界
      if (_ball.y < _limit.top + _ball.r) {


        _ball.y = _limit.top + _ball.r;

        _ball.vY = -_ball.vY;
        _ball.color = randomRGB();
      }
      //限定左边界
      if (_ball.x < _limit.left + _ball.r) {
        _ball.x = _limit.left + _ball.r;
        _ball.vX = -_ball.vX;
        _ball.color = randomRGB();
      }
      //限定右边界
      if (_ball.x > _limit.right - _ball.r) {
        var newBall=fromBall(_ball);
        newBall.r=newBall.r/2;
        newBall.vX=-newBall.vX;
        newBall.vY=-newBall.vY;
        _balls.add(newBall);

        _ball.r=_ball.r/2;
        _ball.x = _limit.right - _ball.r;
        _ball.vX = -_ball.vX;
        _ball.color = randomRGB();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        painter: RunBallView(context, _balls, _limit),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.forward();
        },
        tooltip: "点击开始",
        child: Icon(Icons.add),
      ),
    );
  }
}
