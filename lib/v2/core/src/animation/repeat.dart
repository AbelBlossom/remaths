part of v2.core;

Node repeatAnimation(
  Node animation, {
  int reps = 2,
  bool reverse = false,
  void Function()? onComplete,
  num? from,
}) {
  return (node) {
    node._lock.value = true;
    var start = from == null ? node.value : from.toDouble();
    node._setValue(start);
    animationLoop(int index) {
      print("index => $index");
      if (index == 0) {
        node._meta.completeListener = null;
        node._lock.value = false;
        node.value = timingAnimation(start,
            duration: node._meta.duration,
            curve: node._meta.curve, onComplete: () {
          node._lock.value = false;
          if (onComplete != null) onComplete();
        });
        return;
      }

      node._meta.completeListener = () {
        if (reverse) {
          if (index == 1) {
            animationLoop(index - 1);
            return;
          }

          node._meta.completeListener = () => animationLoop(index - 1);
          node.value = timingAnimation(
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

    animationLoop(reps);
  };
}
