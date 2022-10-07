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
              width.value = withDelay(
                  withSpring2(
                    size.width * random(),
                  ),
                  200);
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
