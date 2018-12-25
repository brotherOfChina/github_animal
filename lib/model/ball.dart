import 'dart:ui';

class Ball {
  double aX; //加速度
  double aY; //加速度y
  double vX; //X速度
  double vY; //Y速度
  double x; //x位置
  double y; //y位置
  Color color; //颜色
  double r; //小球半径
  Ball({this.x,this.y,this.aX,this.aY,this.vX,this.vY,this.color,this.r});
}
