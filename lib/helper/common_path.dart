import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'dart:math';
Color randomRGB(){
  Random random=new Random();
  int r=30+random.nextInt(200);
  int g=30+random.nextInt(205);
  int b=30+random.nextInt(205);
  return Color.fromARGB(255, r, g, b);
}
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
///角度转弧度
double _rad(double deg) {
  return deg * pi / 180;
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
///网格path
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
///正n角星path
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
///正n边形path
Path regularPolygonPath(int num, double R) {
  double r = R * cos(_rad(360 / num / 2)); //!!一点解决
  return nStarPath(num, R, r);
}

