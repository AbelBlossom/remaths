part of remaths.v2;

Node setValue(
  double value, {
  void Function()? onComplete,
}) {
  return (node) {
    return withTiming(value, duration: 0, onComplete: onComplete)(node);
  };
}
