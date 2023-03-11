part of v2.core;

//FIXME: withRepeat don't work with this
Node sequenceAnimation(List<Node> animations, {void Function()? onComplete}) {
  var anim = animations.reversed.toList();
  return (node) {
    animationLoop(int index) {
      if (index < 0) {
        if (onComplete != null) {
          onComplete();
        }
        return;
      }
      anim[index](node);
      if (node._lock.value) {
        print("locked");
        late void Function() listener;
        listener = () {
          print("added listener");
          if (!node._lock.value) {
            animationLoop(--index);
            node._meta.completeListener = () => animationLoop(index - 1);
          }
        };

        node._lock.addListener(listener);
        return;
      } else {
        print("else");
        node._meta.completeListener = () => animationLoop(--index);
      }
    }

    animationLoop(anim.length - 1);
  };
}
