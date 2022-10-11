part of remaths.v2;

var useSharedValue = (num value, TickerProvider vsync) {
  return SharedValue(value.toDouble(), vsync: vsync);
};
