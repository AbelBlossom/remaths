import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class VersionTwoTrial extends StatefulWidget {
  const VersionTwoTrial({Key? key}) : super(key: key);

  @override
  State<VersionTwoTrial> createState() => _VersionTwoTrialState();
}

class _VersionTwoTrialState extends State<VersionTwoTrial>
    with TickerProviderStateMixin {
  late Size size;
  late SharedValue width;
  @override
  void initState() {
    width = useSharedValue(20.0, this);
    super.initState();
  }

  @override
  void dispose() {
    width.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: width.notifier,
            builder: (context, child) {
              // print(width.diff);
              return SizedBox(
                width: min(max(width.value, 10), size.width - 50),
                height: 30,
                child: child,
              );
            },
            child: Container(
              color: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              width.value = withRepeat(withTiming2(100), reverse: false);
              // width.value = withTiming2(200);
              // width.value = withSequence2([
              //   withTiming2(
              //     10.0,
              //     onComplete: () {
              //       print("finished 1");
              //     },
              //   ),
              //   withSpring2(
              //     100.0,
              //     duration: 1000,
              //     damping: 6.3,
              //     onComplete: () {
              //       // print("finished 2");
              //     },
              //   ),
              //   withTiming2(
              //     20.0,
              //     delay: 300,
              //     onComplete: () {
              //       // print("finished 3");
              //     },
              //   ),
              //   withSpring2(
              //     40.0,
              //     delay: 400,
              //     onComplete: () {
              //       // print("finished 4");
              //     },
              //   ),
              // ], onComplete: () {
              //   print("finished all");
              // });
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
