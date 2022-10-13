import 'package:flutter/widgets.dart';
import 'package:remaths/remaths.dart';

extension SharedValueExtension on num {
  SharedValue asSharedValue(TickerProvider vsync) {
    return useSharedValue(this, vsync);
  }
}
