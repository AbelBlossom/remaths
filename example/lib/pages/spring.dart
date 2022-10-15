import 'package:flutter/material.dart';

import 'package:remaths/remaths.dart';

class SpringAnimation extends StatefulWidget {
  const SpringAnimation({Key? key}) : super(key: key);

  @override
  _SpringAnimationState createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation>
    with TickerProviderStateMixin {
  late SharedValue x;
  late SharedValue y;
  double dif = 0;

  @override
  void initState() {
    super.initState();
    x = 100.asSharedValue(this);
    y = 30.asSharedValue(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spring Animation"),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: x.mergeWith([y.animation]),
            builder: (context, child) {
              dif = diff(x);
              return Positioned(
                top: y.value,
                left: x.value,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    y.value += details.delta.dy;
                    x.value += details.delta.dx;
                  },
                  onPanEnd: (details) {
                    // x.withTiming(200.0, curve: Curves.easeInCubic);
                    // y.withTiming(30.0, curve: Curves.easeInCubic);
                    x.value = withSpring(100);
                    y.value = withSpring(30);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(cond(lessOrEq(dif, 0), 'true', 'false')),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
