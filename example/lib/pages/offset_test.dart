import 'package:flutter/material.dart';

import 'package:remaths/_remaths.v1.dart';

class OffsetTest extends StatefulWidget {
  const OffsetTest({Key? key}) : super(key: key);

  @override
  State<OffsetTest> createState() => _OffsetTestState();
}

class _OffsetTestState extends State<OffsetTest> {
  var offset = const Offset(0, 0);
  var _temp = const Offset(0, 0);
  Color color = Colors.red;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: offset,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _temp += details.delta;
                  offset = interpolate<Offset, Offset>(
                    _temp,
                    [Offset.zero, Offset(size.width, size.height)],
                    [Offset.zero, Offset(size.width / 2, size.height / 2)],
                  );
                  color = interpolate<Offset, Color>(
                    _temp,
                    [Offset.zero, Offset(size.width, size.height)],
                    [Colors.red, Colors.red],
                  );

                  setState(() {});
                },
                onPanEnd: (d) {
                  _temp = offset;
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
