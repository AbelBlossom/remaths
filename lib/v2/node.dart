part of remaths.v2;

var useSharedValue = (double value, TickerProvider vsync) {
  return SharedValue(value, vsync: vsync);
};
