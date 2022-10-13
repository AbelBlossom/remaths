part of v2.core;

Node withSequence(List<Node> animations, {void Function()? onComplete}) {
  var anim = animations.reversed.toList();
  return (node) {
    animationLoop(int index) {
      if (index < 0) {
        return;
      }
      anim[index](node);
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

    animationLoop(anim.length - 1);
  };
}
