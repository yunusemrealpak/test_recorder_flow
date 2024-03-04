import 'package:flutter/widgets.dart';
import 'package:test_recorder_flow/core/extensions/offset_extensions.dart';
import 'package:test_recorder_flow/core/extensions/record_extensions.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

import '../utils/helper_functions.dart';

class TRGestureDetectorManager {
  static final TRGestureDetectorManager _instance = TRGestureDetectorManager._internal();
  static TRGestureDetectorManager get instance => _instance;
  TRGestureDetectorManager._internal();

  void onTap(GlobalKey key) {
    final size = getWidgetSize(key);
    final offset = getWidgetOffset(key);
    final points = getWidgetPoints(offset, size);

    final recordEvent = """
- tapOn:
    point: ${points.center.convertPercentage.toPercentageString}
""";

    TestRocerderFlow.instance.recordEvent(recordEvent);
  }
}
