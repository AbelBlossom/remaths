part of remaths;

typedef void OnSized(Measurement measurement);

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

  static Measurement _getMeasurement(RenderBox box, Offset offset) {
    var _m = Measurement();
    var size = box.size;
    _m.width = size.width;
    _m.height = size.height;
    var offset = box.localToGlobal(Offset(0, 0));
    _m.x = offset.dx;
    _m.y = offset.dy;
    return _m;
  }
}
