part of v2.core;

Node delayAnimation(Node node, int delay) {
  return (main) {
    main._meta.setDelayed(() {
      node(main);
    }, delay);
  };
}
