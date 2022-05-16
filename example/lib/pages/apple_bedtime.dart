import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';
import 'dart:math' as math;

//create a statefull widget
class AppleBedtime extends StatefulWidget {
  const AppleBedtime({Key? key}) : super(key: key);
  @override
  _AppleBedtimeState createState() => _AppleBedtimeState();
}

const STROKE_WIDTH = 50.0;
const PADDING = 30.0;

// implement the state
class _AppleBedtimeState extends State<AppleBedtime> {
  double startAngle = 0.0;
  double endAngle = 1.0;
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
                    painter:
                        _AppleBedtimePainter(start: startAngle, end: endAngle),
                    child: Stack(
                      children: [
                        Cursor(
                          startAngle: startAngle,
                          getAngle: (_a) {
                            setState(() {
                              startAngle = _a;
                            });
                          },
                        ),
                        Cursor(
                          startAngle: endAngle,
                          getAngle: (_a) {
                            setState(() {
                              endAngle = _a;
                            });
                          },
                        ),
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
  final double startAngle;
  const Cursor({Key? key, this.getAngle, this.startAngle = 0})
      : super(key: key);
  @override
  State<Cursor> createState() => _CursorState();
}

class _CursorState extends State<Cursor> {
  Offset _offset = Offset(0, 0);
  Offset _pos = Offset(0, 0);
  final cursorR = (STROKE_WIDTH - 4) / 2;

  _run(Size? size, [firstrun = false]) {
    if (size == null) {
      return;
    }
    var R = (size.width / 2) - (PADDING / 2 + STROKE_WIDTH / 2);
    var WIDTH = size.width;

    var center = Offset((WIDTH / 2) - cursorR, (WIDTH / 2) - cursorR);
    var cartesian = _offset - center;
    var a =
        firstrun ? widget.startAngle : math.atan2(cartesian.dy, cartesian.dx);

    var y = R * math.sin(a);
    var x = R * math.cos(a);

    setState(() {
      _pos = Offset(x, y) + center;
    });
    if (widget.getAngle != null) {
      widget.getAngle!(a);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _run(MediaQuery.of(context).size, true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var R = (size.width / 2) - (PADDING / 2 + STROKE_WIDTH / 2);
    // var WIDTH = size.width;

    return Positioned(
      top: _pos.dy,
      left: _pos.dx,
      child: GestureDetector(
        onPanUpdate: (details) {
          _offset += details.delta;

          // var center = Offset((WIDTH / 2) - cursorR, (WIDTH / 2) - cursorR);
          // var cartesian = _offset - center;
          // var a = math.atan2(cartesian.dy, cartesian.dx);

          // var y = R * math.sin(a);
          // var x = R * math.cos(a);
          // setState(() {
          //   _pos = Offset(x, y) + center;
          // });

          _run(size);
        },
        onPanEnd: (_d) {
          _offset = _pos;
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
  final double start;
  final double end;
  _AppleBedtimePainter({required this.start, required this.end});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = STROKE_WIDTH
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width / 2, size.height / 2);

    var R = (size.width / 2) - (PADDING / 2 + STROKE_WIDTH / 2);
    var rect = Rect.fromCircle(center: center, radius: R);
    canvas.drawArc(rect, 0, toRad(360), false, paint);

    paint.color = Colors.orange;
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.orange[900]!,
        Colors.orange[400]!,
      ],
    ).createShader(rect);
    // i dont know why but the arc is not drawing properly :)

    var sweep = (end < start ? (math.pi * 2) + end : end) - start;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: R), start, sweep, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
