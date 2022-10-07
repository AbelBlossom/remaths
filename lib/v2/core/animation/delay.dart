part of remaths;

AnimationFunc withDelay(AnimationFunc func, int delay) {
  return (node) {
    Future.delayed(Duration(milliseconds: delay), () {
      func(node);
    });
  };
}
