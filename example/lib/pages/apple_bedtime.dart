import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';
import 'dart:math' as math;

//create a statefull widget
class AppleBedtime extends StatefulWidget {
  const AppleBedtime({Key? key}) : super(key: key);
  @override
  _AppleBedtimeState createState() => _AppleBedtimeState();
}

const STROKE_WIDTH = 40.0;
const PADDING = 30.0;

// implement the state
class _AppleBedtimeState extends State<AppleBedtime> {
  @override
  Widget build(BuildContext context) {
    // get the screen size
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          width: size.width,
          height: size.width,
          color: Colors.grey[800],
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                    painter: _AppleBedtimePainter(),
                    child: Stack(
                      children: [
                        Cursor(),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cursor extends StatefulWidget {
  final Function(double angle)? getAngle;
  const Cursor({Key? key, this.getAngle}) : super(key: key);
  @override
  State<Cursor> createState() => _CursorState();
}

class _CursorState extends State<Cursor> {
  Offset _offset = Offset(0, 0);
  Offset _pos = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var R = (size.width / 2) - (PADDING / 2 + STROKE_WIDTH / 2);
    var WIDTH = size.width;
    var cursorR = (STROKE_WIDTH - 5) / 2;

    return Positioned(
      top: _pos.dy,
      left: _pos.dx,
      child: GestureDetector(
        onPanUpdate: (details) {
          _offset += details.delta;

          var center = Offset((WIDTH / 2) - cursorR, (WIDTH / 2) - cursorR);
          var cartesian = _offset - center;
          var a = math.atan2(cartesian.dy, cartesian.dx);

          var y = R * math.sin(a);
          var x = R * math.cos(a);
          setState(() {
            _pos = Offset(x, y) + center;
          });
        },
        child: Container(
          width: cursorR * 2,
          height: cursorR * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(STROKE_WIDTH / 2),
          ),
        ),
      ),
    );
  }
}

// create the painter
class _AppleBedtimePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = STROKE_WIDTH
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width / 2, size.height / 2);

    var R = (size.width / 2) - (PADDING / 2 + STROKE_WIDTH / 2);

    canvas.drawArc(Rect.fromCircle(center: center, radius: R), 0, toRad(360),
        false, paint);

    paint.color = Colors.orange;

    canvas.drawArc(Rect.fromCircle(center: center, radius: R), 0, toRad(180),
        false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
