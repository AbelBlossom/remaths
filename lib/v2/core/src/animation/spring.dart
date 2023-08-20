part of v2.core;

NodeFunc springAnimation(
  double toValue, {
  int duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
  double? from,
  void Function()? onComplete,
}) {
  return _animate(
    toValue,
    from: from,
    duration: duration,
    onComplete: onComplete,
    tag: _Tag.spring,
    curve: SpringCurve.custom(
      damping: damping,
      mass: mass,
      stiffness: stiffness,
      velocity: velocity,
    ),
  );
}
