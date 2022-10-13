part of v2.core;

Node withTiming(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
  num? from,
}) {
  return (node) {
    node._meta.from = (from ??= node._val).toDouble();
    node._meta.to = toValue;
    node._meta.duration = duration;
    node._resetController(duration);
    node._meta.curve = curve;
    node._setAnimation(
        Tween(begin: node._meta.from, end: node._meta.to).animate(
          CurvedAnimation(
            parent: node.controller,
            curve: curve,
          ),
        ),
        onComplete);

    if (delay != null) {
      Future.delayed(Duration(milliseconds: delay), () {
        node.controller.forward();
      });
    } else {
      node.controller.forward();
    }
  };
}
