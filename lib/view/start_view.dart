import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class StartView extends CustomPainter {
  Paint mHelpPaint;
  final BuildContext context;
  Color _color;
  StartView(this.context,Color _color) {
    mHelpPaint = new Paint();
    mHelpPaint.style = PaintingStyle.stroke;
    mHelpPaint.color = _color;
    mHelpPaint.isAntiAlias = true;
    this._color=_color;
    print(this._color);

  }

  Path getPath(int step, Size winSize) {
    Path path = new Path();
    for (int i = 0; i < winSize.height / step + 1; i++) {
      path.moveTo(0, step * i.toDouble());
      path.lineTo(winSize.width, step * i.toDouble());
    }

    for (int i = 0; i < winSize.width / step + 1; i++) {
      path.moveTo(step * i.toDouble(), 0);
      path.lineTo(step * i.toDouble(), winSize.height);
    }
    return path;
  }

  ///画作标系
   drawCoo(Canvas canvas, Size winSize) {

     Size coo = new Size(winSize.width / 2, winSize.height / 2);
    ///初始化网格画笔
    Paint paint = new Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPath(cooPath(coo, winSize), paint);
    canvas.drawLine(
        new Offset(coo.width, 0), new Offset(coo.width - 6, 10), paint);
    canvas.drawLine(
        new Offset(coo.width, 0), new Offset(coo.width + 6, 10), paint);
    canvas.drawLine(new Offset(winSize.width, coo.height),
        new Offset(winSize.width - 10, coo.height - 6), paint);
    canvas.drawLine(new Offset(winSize.width, coo.height),
        new Offset(winSize.width - 10, coo.height + 6), paint);

    ///绘制直线
    paint.style = PaintingStyle.fill;
    canvas.translate(coo.width, coo.height); //移动到坐标系原点
  }

  ///坐标系
  Path cooPath(Size coo, Size winSize) {
    Path path = new Path();
    //
    path.moveTo(0, coo.height);
    path.lineTo(winSize.width, coo.height);

    path.moveTo(coo.width, 0);
    path.lineTo(coo.width, winSize.height);
    return path;
  }
  void drawGrid(Canvas canvas,Size winSize){
    Path path = getPath(20, winSize);
    mHelpPaint.color=Colors.black;
    mHelpPaint.style=PaintingStyle.stroke;
    canvas.drawPath(path, mHelpPaint);
  }
  void drawStar(Canvas canvas,Size winSize){
    Size coo = new Size(winSize.width / 2, winSize.height / 2);
    mHelpPaint.color=this._color;
    mHelpPaint.style=PaintingStyle.fill;
    canvas.translate(-coo.width, -coo.height+160);
    canvas.save();
    for(int i=4; i<10;i++){
      canvas.translate(64, 0);
      canvas.drawPath(nStarPath(i, 30, 15), mHelpPaint);
    }
    canvas.restore();
    canvas.translate(0, 130);
    canvas.save();
    for(int i=5;i<10;i++){
      canvas.translate(64, 0);
      canvas.drawPath(regularStarPath(i, 30), mHelpPaint);
    }
    canvas.restore();
    canvas.translate(0, 130);
    canvas.save();
    for(int i=4;i<10;i++){
      canvas.translate(64, 0);
      canvas.drawPath(regularPolygonPath(i, 30), mHelpPaint);
    }
    canvas.restore();
  }
  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    drawGrid(canvas, winSize);
    drawCoo(canvas, winSize);
    drawStar(canvas, winSize);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /**
   * n角星路径
   *
   * @param num 几角星
   * @param R   外接圆半径
   * @param r   内接圆半径
   * @return n角星路径
   */
  Path nStarPath(int num, double R, double r) {
    Path path = new Path();
    double perDeg = 360 / num; //尖角的度数
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

    path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
    for (int i = 0; i < num; i++) {
      path.lineTo(
          cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
      path.lineTo(
          cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
    }
    path.close();
    return path;
  }

  double _rad(double deg) {
    return deg * pi / 180;
  }



  /**
   * 画正n角星的路径:
   *
   * @param num 角数
   * @param R   外接圆半径
   * @return 画正n角星的路径
   */
  Path regularStarPath(int num, double R) {
    double degA, degB;
    if (num % 2 == 1) {
      //奇数和偶数角区别对待
      degA = 360 / num / 2 / 2;
      degB = 180 - degA - 360 / num / 2;
    } else {
      degA = 360 / num / 2;
      degB = 180 - degA - 360 / num / 2;
    }
    double r = R * sin(_rad(degA)) / sin(_rad(degB));
    return nStarPath(num, R, r);
  }

  /**
   * 画正n边形的路径
   *
   * @param num 边数
   * @param R   外接圆半径
   * @return 画正n边形的路径
   */
  Path regularPolygonPath(int num, double R) {
    double r = R * cos(_rad(360 / num / 2)); //!!一点解决
    return nStarPath(num, R, r);
  }
}
