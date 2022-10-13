part of v2.core;

Node withDelay(Node func, int delay) {
  return (node) {
    Future.delayed(Duration(milliseconds: delay), () {
      func(node);
    });
  };
}
