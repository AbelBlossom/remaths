part of v2.core;

Node delayAnimation(Node func, int delay) {
  return (node) {
    Future.delayed(Duration(milliseconds: delay), () {
      func(node);
    });
  };
}
