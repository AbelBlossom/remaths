part of remaths;

Node withRepeat(Node animation, {int numberOfReps = 2, bool reverse = false}) {
  return (node) {
    var start = node.value;
    animationLoop(int index) {
      if (index <= 0) return;
      node.meta.completeListener = () {
        if (reverse) {
          if (index == 1) return;
          node.meta.completeListener = () => animationLoop(index - 1);
          node.value = withTiming2(
            node.meta.from,
            duration: node.meta.duration,
            curve: node.meta.curve.flipped,
          );
        } else {
          animationLoop(index - 1);
        }
      };
      node._val = start;
      animation(node);
    }

    animationLoop(numberOfReps);
  };
}
