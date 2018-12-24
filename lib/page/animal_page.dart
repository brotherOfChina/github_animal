import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/view/start_view.dart';
import 'package:flutter_animate/view/animals_view.dart';

class AnimalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimalPageState();
  }
}

class _AnimalPageState extends State<AnimalPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> colorAnimation;
  Color _color;
  int _num;
  Animation<int> numAnimation;
  Animation<double> animation;
  double _R = 15;


  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    colorAnimation =
        ColorTween(begin: Colors.yellow, end: Colors.red).animate(controller)
          ..addListener(() {
            setState(() {
              _color = colorAnimation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    numAnimation = IntTween(begin: 5, end: 50).animate(controller)
      ..addListener(() {
        setState(() {
          _num = numAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation = Tween(begin: 15.0, end: 100.0).animate(
       controller)
      ..addListener(() {
        setState(() {
          _R = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("赵鹏军"),
      ),
      body: CustomPaint(
        painter: AnimalView(context, _R, _color, _num),
        child: Text("hello"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
