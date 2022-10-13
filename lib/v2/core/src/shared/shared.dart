part of v2.core;

typedef Node = void Function(Shared node);
typedef AnimationListener = void Function();

abstract class Shared {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  late AnimationController controller;
  final TickerProvider vsync;
  bool _sequenceLocked = false;

  final ValueNotifier<bool> _lock = ValueNotifier(false);

  late _AnimationInfo _meta;

  Shared(this._val, {required this.vsync}) {
    _notifier = ValueNotifier(_val);
    _status = ValueNotifier(null);
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: _kDuration),
    );
    _meta = _AnimationInfo(
        curve: Curves.linear, duration: _kDuration, from: 0.0, to: 0.0);
  }

  _resetController(int? duration) {
    _stopCurrent();
    controller.dispose();
    controller = AnimationController(
      vsync: vsync,
      duration: Duration(
        milliseconds: duration ?? _kDuration,
      ),
    );
  }

  _setAnimation(Animation<double> animation, [void Function()? onComplete]) {
    _meta.removeListener();
    _meta.animation = animation;
    _meta.listener = () => _setValue(animation.value);
    _meta.animation?.addStatusListener((status) {
      _status.value = status;
      if (status == AnimationStatus.completed) {
        if (onComplete != null) {
          onComplete();
        }
        if (_meta.hasCompleteLister) {
          _meta.completeListener!();
        }
      }
    });
    _meta.animation!.addListener(_meta.listener!);
  }

  double get value => _val;

  double operator +(dynamic other) => value + getValue(other);

  double operator -(dynamic other) => value - getValue(other);

  double operator /(dynamic other) => value / getValue(other);

  double operator *(dynamic other) => value * getValue(other);

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
    _val = val;
    _notifier.value = _val;
  }

  ValueNotifier<double> get notifier => _notifier;

  dispose() {
    _stopCurrent();
    controller.dispose();
    _notifier.dispose();
  }

  @protected
  _stopCurrent() {
    controller.stop();
  }
}
