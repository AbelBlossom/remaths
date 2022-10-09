part of remaths;

Node withTiming2(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
}) {
  return (SharedValue node) {
    if (toValue == node.value) return;
    node._details.from = node._val;
    node._details.to = toValue;
    node.resetController(duration);
    node._details.curve = curve;
    node.setAnimation(
        Tween(begin: node.value, end: toValue).animate(
          CurvedAnimation(
            parent: node._controller,
            curve: curve,
          ),
        ),
        onComplete);

    if (delay != null) {
      Future.delayed(Duration(milliseconds: delay), () {
        node._controller.forward();
      });
    } else {
      node._controller.forward();
    }
  };
}
