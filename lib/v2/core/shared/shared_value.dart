part of remaths;

typedef void Node(SharedValue node);
typedef void AnimationListener();
// const double _kDamping = 20;
// const double _kStiffness = 180;
// const double _kMass = 1.0;
// const double _kVelocity = 0.0;
// const int _kDuration = 300;

class SharedValue {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  late AnimationController _controller;
  final TickerProvider vsync;
  bool _sequenceLocked = false;
  late _AnimationDetails _details;

  SharedValue(this._val, {required this.vsync}) {
    _notifier = ValueNotifier(_val);
    _status = ValueNotifier(null);
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: _kDuration),
    );
    _details = _AnimationDetails(
        curve: Curves.linear, duration: _kDuration, from: 0.0, to: 0.0);
  }

  resetController(int? duration) {
    //FIXME: find a performant way then disposing contollers and creating them
    print("resetting controller");
    _stopCurrent();
    _controller.dispose();
    print("disposing");
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(
        milliseconds: duration ?? _kDuration,
      ),
    );
  }

  setAnimation(Animation<double> animation, [void Function()? onComplete]) {
    _details.removeListener();
    _details.animation = animation;
    _details.listener = () => _setValue(animation.value);
    _details.animation?.addStatusListener((status) {
      // print("status ${status}");
      if (status == AnimationStatus.completed) {
        // print("animation complete");
        if (onComplete != null) {
          onComplete();
        }
        if (_details.hasCompleteLister) {
          _details.completeListener!();
        }
      }
    });
    _details.animation!.addListener(_details.listener!);
  }

  double get value => _val;

  double operator +(dynamic other) =>
      value + cond(other is _InternalShared, other.value, other);

  double operator -(dynamic other) =>
      value - cond(other is _InternalShared, other.value, other);

  double operator /(dynamic other) =>
      value / cond(other is _InternalShared, other.value, other);

  double operator *(dynamic other) =>
      value * cond(other is _InternalShared, other.value, other);

  call(dynamic _value) {
    value = _value;
  }

  set status(AnimationStatus? status) {
    _status.value = status;
  }

  /// return the status of the currently running Animation
  AnimationStatus? get status => _status.value;

  set value(dynamic val) {
    assert(val is Node || num.tryParse(val.toString()) != null);
    if (_sequenceLocked) {}
    _sequenceLocked = false;

    val is Node ? val(this) : _setValue(val);
  }

  get diff {
    if (_prev != null) {
      return _val - _prev!;
    }
    return 0;
  }

  _setValue(double val) {
    _prev = _val;
    _val = val.toDouble();
    _notifier.value = _val;
  }

  ValueNotifier<double> get notifier => _notifier;

  dispose() {
    _stopCurrent();
    _controller.dispose();
    _notifier.dispose();
  }

  _stopCurrent() {
    _controller.stop();
  }

  T interpolate<T>(List<double> inputRange, List<T> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
    return _interpolateAll<T>(
      _val,
      inputRange,
      outputRange,
      extrapolate,
      right,
    );
  }
}
