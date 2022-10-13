part of remaths.v2;

Node withRepeat(
  Node animation, {
  int numberOfReps = 2,
  bool reverse = false,
  num? from,
}) {
  return (node) {
    node._lock.value = true;
    var start = from == null ? node.value : from.toDouble();
    node._setValue(start);
    animationLoop(int index) {
      if (index == 0) {
        node._lock.value = false;
        return;
      }

      node._meta.completeListener = () {
        if (reverse) {
          if (index == 1) {
            animationLoop(index - 1);
            return;
          }

          node._meta.completeListener = () => animationLoop(index - 1);
          node.value = withTiming(
            start,
            duration: node._meta.duration,
            curve: node._meta.curve,
          );
        } else {
          if (index != 1) {
            node.value = start;
          }
          animationLoop(index - 1);
        }
      };
      // node._val = start;
      animation(node);
    }

    animationLoop(numberOfReps);
  };
}
