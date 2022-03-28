import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';
import 'dart:math';

class NodeTesting extends StatefulWidget {
  const NodeTesting({Key? key}) : super(key: key);

  @override
  State<NodeTesting> createState() => _NodeTestingState();
}

class _NodeTestingState extends State<NodeTesting>
    with TickerProviderStateMixin {
  late SharedValue x;
  _NodeTestingState() {
    x = SharedValue(50, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Node API')),
      body: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
                animation: x.notifier,
                builder: (context, child) {
                  return Container(
                    height: 100,
                    width: x.value,
                    color: Colors.red,
                    child: child,
                  );
                }),
            TextButton(
                onPressed: () {
                  x.value = withSpring(
                    random(100, 200),
                    // damping: 8,
                    duration: 500,
                  );
                  print(random());
                },
                child: Text("RUN"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    x.dispose();
  }
}
