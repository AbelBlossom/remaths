part of v2.core;

Node springAnimation(
  double toValue, {
  int duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
  void Function()? onComplete,
}) {
  //TODO: implement using the Default Flutter Simulation
  return timingAnimation(
    toValue,
    duration: duration,
    onComplete: onComplete,
    curve: SpringCurve.custom(
      damping: damping,
      mass: mass,
      stiffness: stiffness,
      velocity: velocity,
    ),
  );
}
