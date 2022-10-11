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
    width = 20.asSharedValue(this);
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
              print(diffClamp(width, 0, 10));

              return SizedBox(
                width: clamp(width, 10, size.width - 50),
                height: 30,
                child: Container(
                  color: interpolateColor(
                    width,
                    [20, 65, 100],
                    [Colors.red, Colors.blue, Colors.green],
                  ),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              // width.value = withRepeat(withSpring2(100), reverse: true);

              width.value = withSpring2(100, onComplete: () {
                print("complete");
              });
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
