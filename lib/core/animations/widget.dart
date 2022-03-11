part of remaths;

/// A widget to listen to values of `AnimatedValue` and render the animation smoothly
class AnimatedValueBuilder extends StatelessWidget {
  final List<SharedValue> values;
  final Widget? child;
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedValueBuilder(
      {Key? key, required this.values, this.child, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(values.map((e) => e.notifier).toList()),
      builder: builder,
      child: child,
    );
  }
}
