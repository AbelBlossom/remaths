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
    return SharedValue(hook.value, vsync: this);
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
