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
Ball fromBall(Ball ball){
  Ball _ball=new Ball();
  _ball.x=ball.x;
  _ball.y=ball.y;
  _ball.color=ball.color;
  _ball.vX=ball.vX;
  _ball.vY=ball.vY;
  _ball.aX=ball.aX;
  _ball.aY=ball.aY;
  _ball.r=ball.r;
  return _ball;
}

