part of v2.core;

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const int _kDuration = 300;

enum Extrapolate {
  extend,
  clamp,
  identity,
}

class SpringCurve extends Curve {
  factory SpringCurve([double damping = 20]) =>
      SpringCurve.custom(damping: damping);
  SpringCurve.custom({
    double damping = 20,
    double stiffness = 180,
    double mass = 1.0,
    double velocity = 0.0,
  }) : _sim = SpringSimulation(
          SpringDescription(
            damping: damping,
            mass: mass,
            stiffness: stiffness,
          ),
          0.0,
          1.0,
          velocity,
        );

  final SpringSimulation _sim;

  @override
  double transform(double t) => _sim.x(t) + t * (1 - _sim.x(1.0));
}
