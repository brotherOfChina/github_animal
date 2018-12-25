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
  Ball _ball;
  var _limit = Rect.fromLTRB(-140, -100, 140, 100);

  @override
  void initState() {
    super.initState();
    _ball =
        Ball(x: 0, y: 0, color: Colors.blue, r: 10, vX: 0, vY: 0, aX: 0, aY: 1);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200000));
    animationController.addListener(() {
      updateBall();
      setState(() {

      });
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
    _ball.x+=_ball.vX;
    _ball.y+=_ball.vY;
    _ball.vX+=_ball.aX;
    _ball.vY+=_ball.aY;
    //设定下边界
    if(_ball.y>_limit.bottom-_ball.r){
      _ball.y=_limit.bottom-_ball.r;
      _ball.vY=-_ball.vY;
      _ball.color=randomRGB();
    }
    //设定上边界
    if(_ball.y<_limit.top+_ball.r){
      _ball.y=_limit.top+_ball.r;
      _ball.vY=-_ball.vY;
      _ball.color=randomRGB();
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
        painter: RunBallView(context, _ball, _limit),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        animationController.forward();
      }
      ,tooltip: "点击开始",child: Icon(Icons.add),),
    );
  }
}
