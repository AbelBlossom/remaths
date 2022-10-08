part of remaths;

Node withDelay(Node func, int delay) {
  return (node) {
    Future.delayed(Duration(milliseconds: delay), () {
      func(node);
    });
  };
}
