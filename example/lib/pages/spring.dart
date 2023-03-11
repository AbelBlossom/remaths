import 'package:flutter/material.dart';

import 'package:remaths/remaths.dart';
import 'package:remaths/v2/core/core.dart';

class SpringAnimation extends HookWidget {
  const SpringAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final x = useSharedValue(100);
    final y = useSharedValue(30);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spring Animation"),
      ),
      body: Stack(
        children: [
          SharedAnimationBuilder(
              values: [x, y],
              builder: (context, child) {
                return Positioned(
                  top: y.value,
                  left: x.value,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      y.value += details.delta.dy;
                      x.value += details.delta.dx;
                    },
                    onPanEnd: (details) {
                      x.value = withSpring(
                        100,
                        stiffness: 140,
                        damping: 12,
                      );
                      y.value = withSpring(
                        30,
                        stiffness: 140,
                        damping: 12,
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(cond(lessOrEq(x.diff, 0), 'true', 'false')),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
