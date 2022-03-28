import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class TimingAnimation extends StatefulWidget {
  TimingAnimation({Key? key}) : super(key: key);

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
        title: Text("Timing Animation"),
      ),
      body: Stack(
        children: [
          SharedValueBuilder(
            values: [x, y],
            builder: (context, child) => Positioned(
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
                  runAllWithTiming(
                    [x, y],
                    [100, 30],
                    curve: Curves.linear,
                  );
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
