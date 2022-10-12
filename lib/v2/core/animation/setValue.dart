part of remaths.v2;

Node setValue(
  double value, {
  void Function()? onComplete,
}) {
  return (node) {
    node._val = value;
    return;
  };
}
