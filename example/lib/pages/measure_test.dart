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
  double w = 60;
  double h = 60;
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
                  if (_measurement != null) {
                    h = 10 + (0.5 * _measurement!.y);
                    w = 10 + (0.5 * _measurement!.x);
                  }
                });
              },
              child: Measure(
                measureOnce: true,
                onSizeChanged: (m) {
                  // setState(() {
                  _measurement = m;
                  // });
                },
                child: Container(
                  width: w,
                  height: h,
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
