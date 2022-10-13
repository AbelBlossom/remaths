part of v2.core;

Node setValue(
  double value, {
  void Function()? onComplete,
}) {
  return (node) {
    node._val = value;
    return;
  };
}
