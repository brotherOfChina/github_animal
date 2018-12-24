import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/view/start_view.dart';
import 'package:flutter_animate/helper/help_view.dart';

class AnimalView extends CustomPainter {
  Paint mPaint;
  BuildContext context;
  double _R;
  int _num;
  Color _color;

  AnimalView(this.context, double r,Color color,int num) {
    mPaint = new Paint();
    mPaint.color = Colors.deepOrange;
    _R = r;
    _color=color;
    _num=num;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    mPaint.color = Colors.black12;
    mPaint.style = PaintingStyle.stroke;
    drawGrid(canvas, winSize, mPaint);
    mPaint.color = Colors.black;
    mPaint.strokeWidth = 2.0;
    drawCoo(canvas, winSize, mPaint);
    mPaint.style = PaintingStyle.fill;
    mPaint.color = _color;
    canvas.translate(100, 100);
    drawNStar(canvas, mPaint, _num, _R,30);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
