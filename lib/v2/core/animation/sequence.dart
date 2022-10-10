part of remaths;

Node withSequence2(List<Node> animations, {void Function()? onComplete}) {
  return (node) {
    animationLoop(int index) {
      // node._completeLister = null;
      if (index >= animations.length && node._sequenceLocked) {
        if (onComplete != null) {
          onComplete();
        }
        return;
      }
      //TODO: add support for `withRepeat`
      node.meta.completeListener = () => animationLoop(index + 1);
      print("looping $index");
      animations[index](node);
    }

    node._sequenceLocked = true;
    animationLoop(0);
  };
}
