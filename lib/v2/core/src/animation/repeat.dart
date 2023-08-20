part of v2.core;

NodeFunc repeatAnimation(
  NodeFunc animation, {
  int reps = 2,
  bool reverse = false,
  void Function()? onComplete,
  num? from,
}) {
  return (node) {
    node._meta._lock.value = true;
    var start = from == null ? node.value : from.toDouble();
    node._setValue(start);
    animationLoop(int index) {
      if (index == 0) {
        node._meta.completeListener = null;
        node.value = timingAnimation(start,
            duration: node._meta.duration,
            curve: node._meta.curve, onComplete: () {
          node._meta._lock.value = false;
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
      animation(node);
    }

    animationLoop(reps);
  };
}
