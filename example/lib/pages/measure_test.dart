import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class MeasureTest extends StatefulWidget {
  const MeasureTest({Key? key}) : super(key: key);

  @override
  State<MeasureTest> createState() => _MeasureTestState();
}

class _MeasureTestState extends State<MeasureTest> {
  Measurement? _measurement;
  double x = 50;
  double y = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Positioned(
            top: y,
            left: x,
            child: GestureDetector(
              onPanUpdate: (det) {
                setState(() {
                  x += det.delta.dx;
                  y += det.delta.dy;
                });
              },
              child: MeasureListener(
                onSizeChanged: (m) {
                  setState(() {
                    _measurement = m;
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.red,
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          child: Text(
            _measurement.toString(),
          ),
        )
      ]),
    );
  }
}
