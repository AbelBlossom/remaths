part of remaths;

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
    _getMeasurements();
  }

  _getMeasurements() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var context = _key.currentContext;
      if (context != null) {
        var box = context.findRenderObject() as RenderBox;
        widget.onSizeChanged
            .call(Measurement._getMeasurement(box, widget.offset));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getMeasurements();
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
