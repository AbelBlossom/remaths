part of v2.core;

NodeFunc delayAnimation(NodeFunc node, int delay) {
  return (main) {
    main._meta.tag = _Tag.delay;
    main._meta.setDelayed(() {
      node(main);
    }, delay);
  };
}
