import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/view/start_view.dart';
import 'package:flutter_animate/view/animals_view.dart';

class AnimalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimalPageState();
  }
}

class _AnimalPageState extends State<AnimalPage> {
  AnimationController controller;
  Animation<double> animation;
  double _R = 25;
  @override
  void initState() {
    super.initState();
    controller=new AnimationController(

    duration: const Duration(milliseconds: 2000));
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
        painter: AnimalView(context, _R),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
