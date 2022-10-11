part of remaths.v2;

extension SharedValueExtension on num {
  SharedValue asSharedValue(TickerProvider vsync) {
    return useSharedValue(this, vsync);
  }
}
