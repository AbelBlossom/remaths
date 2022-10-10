part of remaths;

class _AnimationInfo {
  Curve curve;
  int duration;
  double from;
  double to;
  Animation? animation;
  AnimationListener? listener;
  AnimationListener? completeListener;

  _AnimationInfo({
    required this.curve,
    required this.duration,
    required this.from,
    required this.to,
  });

  bool get hasAnimation => animation != null;

  bool get hasListener => listener != null;

  bool get hasCompleteLister => completeListener != null;

  removeListener() {
    if (hasAnimation && hasListener) {
      animation!.removeListener(listener!);
    }
  }
}
