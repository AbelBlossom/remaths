import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class TimingAnimation extends StatefulWidget {
  const TimingAnimation({Key? key}) : super(key: key);

  @override
  _TimingAnimationState createState() => _TimingAnimationState();
}

class _TimingAnimationState extends State<TimingAnimation>
    with TickerProviderStateMixin {
  late SharedValue x;
  late SharedValue y;

  @override
  void initState() {
    super.initState();
    x = SharedValue(100, vsync: this);
    y = SharedValue(30, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timing Animation"),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: x.mergeWith([y.animation]),
            builder: (context, child) => Positioned(
              top: y.value,
              left: x.value,
              child: GestureDetector(
                onPanUpdate: (details) {
                  y.value += details.delta.dy;
                  x.value += details.delta.dx;
                },
                onPanEnd: (details) {
                  x.withTiming(100, curve: Curves.bounceOut);
                  y.withTiming(30, curve: Curves.bounceOut);
                },
                child: child,
              ),
            ),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
            ),
          )
        ],
      ),
    );
  }
}
