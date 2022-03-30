part of remaths;

/// Use [_Spring] in place of any curve.
///
/// Opinionated curves are [_Spring.underDamped], [_Spring.criticallyDamped], [_Spring.overDamped].
/// This is the most common way to use [_Spring].
///
/// If you wish to fine tune the damping action, use `Sprung()` which defaults to `Sprung(20)` and
/// is the same as [_Spring.criticallyDamped]. Changing the value will fine tune the damping action.
///
/// If you want full control over making custom spring curves, [Spring.custom] allows you to adjust
/// damping, stiffness, mass, and velocity.
///
/// ```
/// Spring.custom(
///   damping: 20,
///   stiffness: 180,
///   mass: 1.0,
///   velocity: 0.0,
/// )
/// ```
class _Spring extends Curve {
  /// A Curve that uses the Flutter Physics engine to drive realistic animations.
  ///
  /// Provides a critically damped spring by default, with an easily override damping value.
  ///
  /// See also: [Sprung.custom], [_Spring.underDamped], [_Spring.criticallyDamped], [_Spring.overDamped]
  factory _Spring([double damping = 20]) => _Spring.custom(damping: damping);

  /// Provides an **under damped** spring, which wobbles loosely at the end.
  // static final underDamped = _Spring(12);

  /// Provides a **critically damped** spring, which overshoots once very slightly.
  // static final criticallyDamped = _Spring(20);

  /// Provides an **over damped** spring, which smoothly glides into place.
  // static final overDamped = _Spring(28);

  /// Provides a critically damped spring by default, with an easily override damping, stiffness,
  /// mass, and initial velocity value.
  _Spring.custom({
    double damping = 20,
    double stiffness = 180,
    double mass = 1.0,
    double velocity = 0.0,
  }) : this._sim = SpringSimulation(
          SpringDescription(
            damping: damping,
            mass: mass,
            stiffness: stiffness,
          ),
          0.0,
          1.0,
          velocity,
        );

  /// The underlying physics simulation.
  final SpringSimulation _sim;

  /// Returns the position from the simulator and corrects the final output `x(1.0)` for tight tolerances.
  @override
  double transform(double t) => _sim.x(t) + t * (1 - _sim.x(1.0));
}
