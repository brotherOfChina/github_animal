import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/view/time_view.dart';
import 'package:flutter_animate/view/ball_view.dart';
import 'package:flutter_animate/model/ball.dart';
import 'package:flutter_animate/helper/common_path.dart';

class DateTimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DataTimePage();
  }
}

class _DataTimePage extends State<DateTimePage>
    with SingleTickerProviderStateMixin {
  List<Ball> _balls;
  double _radius = 3;
  AnimationController animationController;
  Rect _limit;

  @override
  void initState() {
    super.initState();
    _balls = createBalls();
    _limit = new Rect.fromLTRB(0, 0,365, 725);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animationController
      ..addListener(() {
        updateBall();
        setState(() {});
      });
    animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          print(animationController);
          animationController.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("zpj"),
      ),
      body: CustomPaint(
        painter: TimeView(context, _balls),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Ball> createBalls() {
    List<Ball> balls = new List();
    Random random = new Random();

    /// 随机生成n个小球
    int num = random.nextInt(30);
    for (int i = 0; i < num; i++) {
      ///生成的小球颜色及半径，速度
      var _r = random.nextDouble() * 10;
      var _vX = random.nextDouble();
      var _vY = random.nextDouble();
      var _aX = random.nextDouble();
      var _aY = random.nextDouble();
      var _color = randomRGB();
      Ball _ball = new Ball(
          r: _r,
          x: 0,
          y: 0,
          vX: _vX,
          vY: _vY,
          color: _color,
          aX: _aX,
          aY: _aY);
      balls.add(_ball);
    }
    return balls;
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

}
