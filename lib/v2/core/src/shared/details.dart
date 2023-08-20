part of v2.core;

enum _Tag {
  delay,
  timing,
  spring,
}

class _AnimationInfo {
  Curve curve;
  int duration;
  double from;
  double to;
  Animation? animation;
  AnimationListener? listener;
  AnimationListener? completeListener;
  StreamSubscription<dynamic>? _delaySub;
  _Tag? tag;
  final ValueNotifier _lock = ValueNotifier(false);
  Function()? _lockListener;

  _AnimationInfo({
    required this.curve,
    required this.duration,
    required this.from,
    required this.to,
  });

  setDelayed(void Function() func, int delay) {
    if (_delaySub != null) {
      _delaySub!.cancel().then((_) {});
    }
    _delaySub = Future.delayed(Duration(milliseconds: delay)).asStream().listen(
      (event) {
        func();
      },
    );
  }

  stopDelayed() {
    if (_delaySub != null) {
      _delaySub!.cancel();
    }
  }

  set lockListener(Function() func) {
    _lockListener = func;
    _lock.addListener(func);
  }

  removeLockListener() {
    if (_lockListener != null) {
      _lock.removeListener(_lockListener!);
    }
  }

  bool get hasAnimation => animation != null;

  bool get hasListener => listener != null;

  bool get hasCompleteLister => completeListener != null;

  callComplete() {
    if (completeListener != null) {
      completeListener!();
    }
  }

  removeListener() {
    if (hasAnimation && hasListener) {
      animation!.removeListener(listener!);
    }
  }
}
