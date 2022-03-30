import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class SpringAnimation extends StatefulWidget {
  const SpringAnimation({Key? key}) : super(key: key);

  @override
  _SpringAnimationState createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation>
    with TickerProviderStateMixin {
  late Tweenable x;
  late Tweenable y;
  double dif = 0;

  @override
  void initState() {
    super.initState();
    x = 100.asTweenable(this);
    y = 30.asTweenable(this);
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
            animation: mergeTweenables([x, y]),
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
                    runAllWithSpring(
                      [x, y],
                      [100, 30],
                    );
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
