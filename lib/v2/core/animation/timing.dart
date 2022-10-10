part of remaths;

Node withTiming2(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
}) {
  return (SharedValue node) {
    // if (toValue == node.value) return;
    node.meta.from = node._val;
    node.meta.to = toValue;
    node.meta.duration = duration;
    node.resetController(duration);
    node.meta.curve = curve;
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
