part of v2.core;

class SharedAnimationBuilder extends StatelessWidget {
  final Widget? child;
  final List<SharedValue> values;
  final Widget Function(BuildContext, Widget?) builder;
  const SharedAnimationBuilder({
    super.key,
    required this.builder,
    this.child,
    this.values = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(values.map((e) => e.animation).toList()),
      builder: builder,
      child: child,
    );
  }
}

class SharedConsumer extends StatelessWidget {
  final Widget? child;
  final List<SharedValue> values;
  final Widget Function(BuildContext, Widget?) builder;
  const SharedConsumer({
    super.key,
    required this.builder,
    this.child,
    this.values = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SharedAnimationBuilder(
      builder: builder,
      key: key,
      values: values,
      child: child,
    );
  }
}
