part of v2.core;

class _SharedHook extends Hook<SharedValue> {
  final double value;
  const _SharedHook(this.value);

  @override
  HookState<SharedValue, Hook<SharedValue>> createState() {
    return _SharedHookState();
  }
}

class _SharedHookState extends HookState<SharedValue, _SharedHook>
    implements TickerProvider {
  Ticker? _ticker;

  @override
  SharedValue build(BuildContext context) {
    var shared = SharedValue(hook.value, vsync: this);
    return shared;
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    if (_ticker != null) {
      _ticker!.dispose();
    }
    return _ticker = Ticker(onTick);
  }
}

SharedValue useSharedValue([double? value]) {
  return use(useMemoized(() => _SharedHook(value ?? 0.0), []));
}

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
