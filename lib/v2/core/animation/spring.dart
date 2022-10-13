part of v2.core;

Node withSpring(
  double toValue, {
  int duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
  void Function()? onComplete,
  int? delay,
}) {
  //TODO: implement using the Default Flutter Simulation
  return withTiming(
    toValue,
    duration: duration,
    delay: delay,
    onComplete: onComplete,
    curve: _Spring.custom(
      damping: damping,
      mass: mass,
      stiffness: stiffness,
      velocity: velocity,
    ),
  );
}
