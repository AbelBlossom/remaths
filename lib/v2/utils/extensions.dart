import 'package:flutter/widgets.dart';
import 'package:remaths/remaths.dart';
import '../core/core.dart';

extension SharedValueExtension on num {
  SharedValue asSharedValue(TickerProvider vsync) {
    return SharedValue(toDouble(), vsync: vsync);
  }
}
