part of v2.core;

NodeFunc setValue(
  double value, {
  void Function()? onComplete,
}) {
  return (node) {
    node._val = value;
    return;
  };
}
