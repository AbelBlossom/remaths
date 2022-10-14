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
  late SharedValue width;
  @override
  void initState() {
    offset = 20.asSharedValue(this);
    width = 30.asSharedValue(this);
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
            animation: width.mergerWith([offset.animation]),
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

              offset.value = withSequence([
                withSpring(100),
                withSpring(10),
                withSpring(300),
                withRepeat(
                  withSpring(300, damping: 10),
                  reps: 3,
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
                  reps: 3,
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
