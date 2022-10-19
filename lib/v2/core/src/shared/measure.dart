part of v2.core;

class Measurement {
  Size size;
  double x;
  double y;
  Measurement({required this.size, required this.x, required this.y});
  static Measurement? _getMeasurement(GlobalKey key) {
    var context = key.currentContext;
    if (context != null) {
      var box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        return Measurement.fromRenderBox(box);
      }
    }

    return null;
  }

  factory Measurement.fromRenderBox(RenderBox box,
      [Offset point = Offset.zero]) {
    var data = box.localToGlobal(point);
    return Measurement(size: box.size, x: data.dx, y: data.dy);
  }
}

Measurement? measure(GlobalKey key) => Measurement._getMeasurement(key);

class MeasureWidget extends StatefulWidget {
  final Function(Measurement measurement) onMeasured;
  final Widget child;
  final int index;
  const MeasureWidget({
    super.key,
    required this.onMeasured,
    required this.child,
    required this.index,
  });

  @override
  State<MeasureWidget> createState() => _MeasureWidgetState();
}

class _MeasureWidgetState extends State<MeasureWidget> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMeasurement();
    });
  }

  @override
  void dispose() {
    print("disposing ${widget.index}");
    super.dispose();
  }

  _getMeasurement() {
    var context = key.currentContext;
    if (context != null) {
      var box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final measurement = Measurement.fromRenderBox(box);
        widget.onMeasured(measurement);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
