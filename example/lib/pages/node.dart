import 'package:flutter/material.dart';
import 'package:remaths/_remaths.v1.dart';

class NodeTesting extends StatefulWidget {
  const NodeTesting({Key? key}) : super(key: key);

  @override
  State<NodeTesting> createState() => _NodeTestingState();
}

class _NodeTestingState extends State<NodeTesting>
    with TickerProviderStateMixin {
  late Tweenable x;
  _NodeTestingState() {
    x = 50.asTweenable(this);
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
                  // print(interpolate(4,
                  //     inputRange: [1, 2, 1],
                  //     outputRange: [0, 1, 4],
                  //     extrapolate: Extrapolate.EXTEND));
                },
                child: const Text("RUN"))
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
