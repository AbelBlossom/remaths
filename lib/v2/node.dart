part of remaths;

var useSharedValue = (double value, TickerProvider vsync) {
  return SharedValue(value, vsync: vsync);
};
