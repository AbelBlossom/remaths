part of remaths.v2;

Node withSequence(List<Node> _animations, {void Function()? onComplete}) {
  var animations = _animations.reversed.toList();
  return (node) {
    animationLoop(int index) {
      if (index < 0) {
        return;
      }
      animations[index](node);
      if (node._lock.value) {
        late void Function() listener;
        listener = () {
          if (!node._lock.value) {
            animationLoop(--index);
            node._meta.completeListener = () => animationLoop(index - 1);
          }
          node._lock.removeListener(listener);
        };

        node._lock.addListener(listener);
        return;
      } else {
        node._meta.completeListener = () => animationLoop(--index);
      }
    }

    animationLoop(animations.length - 1);
  };
}
