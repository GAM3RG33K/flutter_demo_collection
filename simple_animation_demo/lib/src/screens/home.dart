import 'dart:math';

import 'package:animation_demo/src/helpers/cat.dart';
import 'package:animation_demo/src/helpers/flap.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> flapAnimation;
  AnimationController flapController;

  static const boxColor = Colors.lightBlue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flapController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        animationBehavior: AnimationBehavior.preserve);

    flapAnimation = Tween(
      begin: (pi * 0.55),
      end: (pi * 0.60),
    ).animate(CurvedAnimation(parent: flapController, curve: Curves.easeInOut));

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    flapController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          break;
        case AnimationStatus.dismissed:
          flapController.forward();
          break;
        case AnimationStatus.completed:
          flapController.reverse();
          break;
        case AnimationStatus.reverse:
          break;
      }
    });

    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
//
////    catController.forward();
//    catController.addStatusListener((status) {
//      switch (status) {
//        case AnimationStatus.forward:
//          break;
//        case AnimationStatus.dismissed:
//          flapController.forward();
//          break;
//        case AnimationStatus.completed:
//          flapController.stop();
//          break;
//        case AnimationStatus.reverse:
//          break;
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: GestureDetector(
        child: Center(
            child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            buildCatAnimation(),
            buildBox(),
            buildLeftFlapAnimation(),
            buildRightFlapAnimation(),
          ],
        )),
        onTap: onTap,
      ),
    );
  }

  void onTap() {
    print("onTap: animationo status: ${catAnimation.status}");

    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      flapController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      flapController.stop();
    }
  }

  Widget buildCatAnimation() {
//    return Cat();
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(height: 200.0, width: 200.0, color: boxColor);
  }

  Widget buildLeftFlapAnimation() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: flapAnimation,
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: flapAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
        child: flap(boxColor),
      ),
    );
  }

  Widget buildRightFlapAnimation() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: flapAnimation,
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: -flapAnimation.value,
            alignment: Alignment.topRight,
          );
        },
        child: flap(boxColor),
      ),
    );
  }
}
