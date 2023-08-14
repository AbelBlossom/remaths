import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';
import 'package:remaths/v2/core/core.dart';

class BasicAnimations extends StatefulWidget {
  const BasicAnimations({super.key});

  @override
  State<BasicAnimations> createState() => _BasicAnimationsState();
}

class _BasicAnimationsState extends State<BasicAnimations>
    with TickerProviderStateMixin {
  late SharedValue value;

  @override
  void initState() {
    super.initState();
    value = 20.0.asSharedValue(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basics"),
      ),
      body: SharedAnimationBuilder(
        values: [value],
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: value.value,
              height: 20,
              color: Colors.red,
            ),
            FilledButton(
                onPressed: () {
                  value.value = withSpring(
                    MediaQuery.of(context).size.width / 1.5,
                    duration: 1000,
                    damping: 6,
                    velocity: 5,
                  );
                },
                child: const Text("Run")),
            FilledButton(
                onPressed: () {
                  value.value = withTiming(20.0);
                },
                child: const Text("Reset"))
          ],
        ),
      ),
    );
  }
}
