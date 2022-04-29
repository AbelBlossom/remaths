part of remaths;

class Measure extends StatefulWidget {
  final OnSized onSizeChanged;
  final Widget child;
  final Offset offset;
  final bool measureOnce;
  Measure({
    Key? key,
    required this.onSizeChanged,
    required this.child,
    this.offset = Offset.zero,
    this.measureOnce = false,
  }) : super(key: key);

  @override
  State<Measure> createState() => _MeasureState();
}

class _MeasureState extends State<Measure> {
  var _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getMeasurements(true);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getMeasurements();
    });
  }

  //TODO: fix method calling several times when `measureOnce` is off
  _getMeasurements([bool fromInit = false]) {
    print("getting messurement");
    var context = _key.currentContext;
    print("callback trigger");
    if (context != null) {
      var box = context.findRenderObject() as RenderBox;
      widget.onSizeChanged
          .call(Measurement._getMeasurement(box, widget.offset));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.measureOnce) _getMeasurements();
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
