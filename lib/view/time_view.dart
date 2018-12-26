import 'dart:math';

import 'package:flutter_animate/helper/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/helper/common_path.dart';
import 'package:flutter_animate/model/ball.dart';

var _balls=new List<Ball>();
class TimeView extends CustomPainter {
  double _radius;
  Paint _mPint;
  Size winSize;
  List<Ball> _balls;

  TimeView(BuildContext context, List<Ball> balls) {
    _mPint = new Paint();
    winSize = MediaQuery.of(context).size;
    _balls=balls;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, 0);
    drawTime(canvas);
    canvas.save();
    for (Ball ball in _balls) {
      _mPint.color = ball.color;
      canvas.drawCircle(new Offset(ball.x, ball.y), ball.r, _mPint);
    }
    canvas.restore();

    updateBalls();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawDigit(int num, Canvas canvas) {
    if (num > 10) {
      return;
    }
//    addBalls(num);
    for (int i = 0; i < digit[num].length; i++) {
      for (int j = 0; j < digit[num][i].length; j++) {
        if (digit[num][i][j] == 1) {
          canvas.save();
          double rX = j * 2 * (_radius + 1) + (_radius + 1);
          double rY = i * 2 * (_radius + 1) + (_radius + 1);
          canvas.translate(rX, rY);
          canvas.drawPath(regularStarPath(5, _radius), _mPint);
          canvas.restore();
        }
      }
    }
  }

  void drawTime(Canvas canvas) {
    DateTime dateTime = new DateTime.now();
    String year = dateTime.year.toString();
    getInt(year, canvas);
    var month = dateTime.month.toString();

    var day = dateTime.day.toString();
    getInt(month + ":" + day, canvas);
    var hour = dateTime.hour.toString();

    var min = dateTime.minute.toString();

    var second = dateTime.second.toString();
    getInt(hour + ":" + min + ":" + second, canvas);
  }

  void getInt(String year, Canvas canvas) {
    _radius = winSize.width / year.length / 18;
    for (int i = 0; i < year.length; i++) {
      if (year[i] == ":") {
        drawDigit(10, canvas);
      } else {
        drawDigit(int.parse(year[i]), canvas);
      }
      canvas.translate(_radius * 18, 0);
    }

    canvas.translate(-year.length * _radius * 18, _radius * 30);
  }
  void addBalls(int num){
    Random random=new Random();
    for(int i=0;i<digit[num].length;i++){
      for(int j=0;i<digit[num][i].length;j++){
        if(digit[num][i][j]==1){
          Ball ball=new Ball();
          ball.aY=0.1;
          ball.vX=pow(-1, random.nextInt(6)*6*random.nextDouble());
          ball.vY=4*random.nextDouble();
          ball.x= j * 2 * (_radius + 1) + (_radius + 1);
          ball.y=i * 2 * (_radius + 1) + (_radius + 1);
          ball.color=randomRGB();
          ball.r=_radius;
          _balls.add(ball);
        }
      }

    }
  }
  void updateBalls() {
    double maxX = 400; //限定x范围大值

    for (Ball ball in _balls) {
      ball.x += ball.vX; //x=xo+v*t-----t=1
      ball.y += ball.vY;
      ball.y += ball.aY; //v=vo+a*t-----t=1

      if (ball.y >= 160) {
        //超过Y底线，反弹
        ball.y = 160;
        ball.vY = -ball.vY * 0.99;
      }

      if (ball.x > maxX) {
        //超过X最大值，反弹
        ball.x = maxX;
        ball.vX = -ball.vX * 0.99;
      }
    }
  }

}
