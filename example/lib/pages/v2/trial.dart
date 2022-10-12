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
  late SharedValue offset;
  @override
  void initState() {
    offset = 20.asSharedValue(this);
    super.initState();
  }

  @override
  void dispose() {
    offset.dispose();
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
            animation: offset.notifier,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(offset.value, 0.0),
                child: child,
              );
            },
            child: SizedBox(
              width: 30,
              height: 30,
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // offset.value = withRepeat(
              //   withTiming(100, duration: 500, curve: Curves.linear),
              //   numberOfReps: 4,
              //   reverse: true,
              //   from: 20.0,
              // );

              offset.value = withSequence([
                // withSpring(300, onComplete: () {
                //   print("Spring Ending");
                // }),
                withSpring(100),
                withSpring(10),
                withSpring(300),
                withRepeat(
                  withSpring(300, damping: 10),
                  numberOfReps: 3,
                  reverse: true,
                  from: 200,
                ),
                withSpring(10),
                withSpring(300),
                withSpring(10),
                withSpring(100),
                withSpring(10),
                withSpring(300),
                withRepeat(
                  withSpring(300, damping: 10),
                  numberOfReps: 3,
                  reverse: true,
                  from: 200,
                ),
                withSpring(200),
                withSpring(10),
                withSpring(100),
                withSpring(10),
              ]);
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
