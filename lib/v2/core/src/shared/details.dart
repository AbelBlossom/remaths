part of v2.core;

class _AnimationInfo {
  Curve curve;
  int duration;
  double from;
  double to;
  Animation? animation;
  AnimationListener? listener;
  AnimationListener? completeListener;
  StreamSubscription<dynamic>? _delaySub;

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

  bool get hasAnimation => animation != null;

  bool get hasListener => listener != null;

  bool get hasCompleteLister => completeListener != null;

  removeListener() {
    if (hasAnimation && hasListener) {
      animation!.removeListener(listener!);
    }
  }
}
