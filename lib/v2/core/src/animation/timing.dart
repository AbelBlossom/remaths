part of v2.core;

NodeFunc timingAnimation(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.ease,
  void Function()? onComplete,
  num? from,
}) {
  return _animate(
    toValue,
    curve: curve,
    from: from,
    duration: duration,
    onComplete: onComplete,
    tag: _Tag.timing,
  );
}

NodeFunc _animate(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.ease,
  void Function()? onComplete,
  _Tag? tag,
  num? from,
}) {
  return (node) {
    node._meta.from = (from ??= node._val).toDouble();
    node._meta.to = toValue;
    node._meta.tag = tag;
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
      onComplete,
    );
    node.controller.forward();
  };
}
