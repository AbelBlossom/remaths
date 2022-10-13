part of remaths.v2;

Node withTiming(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
}) {
  return (SharedValue node) {
    node._meta.from = node._val;
    node._meta.to = toValue;
    node._meta.duration = duration;
    node.resetController(duration);
    node._meta.curve = curve;
    node.setAnimation(
        Tween(begin: node.value, end: toValue).animate(
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
