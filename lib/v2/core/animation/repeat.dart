part of remaths;

Node withRepeat(Node animation, [int numberOfReps = 2, bool reverse = true]) {
  return (node) {
    var start = node.value;
    animationLoop(int index) {
      if (index <= 0) {
        return;
      }
      node._details.completeListener = () {
        if (reverse) {
          node.value = withTiming2(
            node._details.from,
            duration: node._details.duration,
            curve: node._details.curve.flipped,
            onComplete: () {
              print("looping $index");
              if (index == 1) return;
              animationLoop(index - 1);
            },
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
