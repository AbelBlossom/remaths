import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class NodeTesting extends StatefulWidget {
  const NodeTesting({Key? key}) : super(key: key);

  @override
  State<NodeTesting> createState() => _NodeTestingState();
}

class _NodeTestingState extends State<NodeTesting>
    with TickerProviderStateMixin {
  late Node x;
  late Node y;
  _NodeTestingState() {
    x = Node(50, vsync: this);
    y = Node(50, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Node API')),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: y.notifier,
            builder: (_, child) {
              return Positioned(
                top: y.value.toDouble(),
                left: x.value.toDouble(),
                child: child!,
              );
            },
            child: GestureDetector(
              onPanUpdate: (details) {
                y.value += details.delta.dy;
                x.value += details.delta.dx;
              },
              onPanEnd: (details) {
                // withTiming(x, 50);
                // withTiming(y, 50);
                x.value = withSpring(50);
                y.value = withSpring(50);
              },
              child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: const Icon(Icons.move_to_inbox)),
            ),
          )
        ],
      ),
    );
  }
}
