import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class TimingAnimation extends HookWidget {
  const TimingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final y = useSharedValue(20);
    final x = useSharedValue(100);
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
                  x.withSpring(100);
                  y.withSpring(30);
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
