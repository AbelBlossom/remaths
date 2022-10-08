part of remaths;

Node setValue(
  double value, {
  void Function()? onComplete,
}) {
  return (node) {
    return withTiming2(value, duration: 0, onComplete: onComplete)(node);
  };
}
