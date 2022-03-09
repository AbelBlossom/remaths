import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:remaths/remaths.dart';

class Measurement {
  double pageX;
  double pageY;
  double width;
  double height;
  double x;
  double y;

  Measurement({
    this.height = 0,
    this.width = 0,
    this.x = 0,
    this.y = 0,
    this.pageX = 0,
    this.pageY = 0,
  });

  @override
  String toString() {
    return "(width: $width, height $height, x: $x, y: $y)";
  }
}

typedef void OnSized(Measurement measurement);

Measurement getMeasurement(RenderBox box, Offset offset) {
  var _m = Measurement();
  var size = box.size;
  _m.width = size.width;
  _m.height = size.height;
  var offset = box.localToGlobal(Offset(0, -92));
  _m.x = offset.dx;
  _m.y = offset.dy;
  return _m;
}

class MeasureListener extends StatefulWidget {
  final OnSized onSizeChanged;
  final Widget child;
  final Offset offset;
  MeasureListener(
      {Key? key,
      required this.onSizeChanged,
      required this.child,
      this.offset = Offset.zero})
      : super(key: key);

  @override
  State<MeasureListener> createState() => _MeasureListenerState();
}

class _MeasureListenerState extends State<MeasureListener> {
  var _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getMesaurements();
  }

  _getMesaurements() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var context = _key.currentContext;
      if (context != null) {
        var box = context.findRenderObject() as RenderBox;
        widget.onSizeChanged.call(getMeasurement(box, widget.offset));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getMesaurements();
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}

class MeasureOnce extends StatefulWidget {
  final OnSized onSized;
  final Widget child;
  final BuildContext context;
  final bool removeAppBarSize;
  const MeasureOnce(
      {Key? key,
      required this.onSized,
      required this.child,
      required this.context,
      this.removeAppBarSize = false})
      : super(key: key);

  @override
  State<MeasureOnce> createState() => _MeasureOnceState();
}

class _MeasureOnceState extends State<MeasureOnce> {
  var _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getMeasurement();
    });
  }

  _getMeasurement() {
    var obj = _key.currentContext?.findRenderObject() as RenderBox;
    var size = obj.size;
    print("size: ${size.height} ${size.width}");
    var offset = obj.localToGlobal(Offset.zero);
    print("ofset: ${offset}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}

class MeasureLister extends StatefulWidget {
  MeasureLister({Key? key}) : super(key: key);

  @override
  State<MeasureLister> createState() => _MeasureListerState();
}

class _MeasureListerState extends State<MeasureLister> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
