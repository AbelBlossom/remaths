import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class VersionTwoTrial extends HookWidget {
  const VersionTwoTrial({super.key});

  @override
  Widget build(BuildContext context) {
    final offset = useSharedValue(10);
    final width = useSharedValue(10);
    print("build");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: width.animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(offset.value, 0.0),
                child: SizedBox(
                  width: width.value,
                  height: 30,
                  child: child,
                ),
              );
            },
            child: Container(
              color: Colors.blue,
            ),
          ),
          TextButton(
            onPressed: () {
              // width.value = withTiming(100);
              // stagger(00, {width: withTiming(100), offset: withTiming(200)});
              // width.value = withSpring(200);
              // offset.value = withSpring(200);

              width.value = withSequence([
                withTiming(100),
                withRepeat(withSpring(200), reps: 4, reverse: true),
                withTiming(
                  10,
                  duration: 1000,
                  onComplete: () {
                    print("done here");
                  },
                ),
              ], onComplete: () {
                print("sequence done");
              });

              // Future.delayed(
              //     Duration(milliseconds: 1000),
              //     () => {
              //           width.value = withTiming(300),
              //         });
              // width.value = withSequence([
              //   withSpring(100),
              //   withSpring(10),
              //   withSpring(300),
              //   withRepeat(
              //     withSpring(300, damping: 10),
              //     reps: 3,
              //     reverse: true,
              //     from: 200,
              //   ),
              //   withSpring(10),
              //   withSpring(300),
              //   withSpring(10),
              //   withSpring(100),
              //   withSpring(10),
              //   withSpring(300),
              //   withRepeat(
              //     withSpring(300, damping: 10),
              //     reps: 3,
              //     reverse: true,
              //     from: 200,
              //   ),
              //   withSpring(200),
              //   withSpring(10),
              //   withSpring(100),
              //   withSpring(10),
              // ]);
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
