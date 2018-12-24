import 'package:flutter_animate/helper/common_path.dart';
import 'package:flutter/cupertino.dart';

void drawCoo(Canvas canvas,Size winSize,Paint paint){
  Size coo=new Size(winSize.width/2, winSize.height/2);
  canvas.drawPath(cooPath(coo, winSize), paint);
}
void drawNStar(Canvas canvas,Paint paint,int num ,double R, double r){
  canvas.drawPath(nStarPath(num, R, r), paint);
}
void drawRegularPoly(Canvas canvas,Paint paint,int num,double R){
  canvas.drawPath(regularPolygonPath(num, R), paint);
}
void drawRegularStar(Canvas canvas,Paint paint, int num ,double R,double x,double y){
  canvas.translate(x, y);
  if(R>70){
    canvas.drawPath(regularStarPath(num, R), paint);

  }else if(R>45&&R<=70){
    canvas.drawPath(regularPolygonPath(num, R), paint);

  }else{
    canvas.drawPath(regularStarPath(num, R), paint);
  }
}

void drawGrid(Canvas canvas ,Size winSize,Paint paint){
  canvas.drawPath(getPath(20, winSize), paint);


}