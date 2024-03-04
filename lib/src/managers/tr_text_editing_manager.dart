import 'package:test_recorder_flow/core/extensions/offset_extensions.dart';
import 'package:test_recorder_flow/core/extensions/record_extensions.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

import '../utils/helper_functions.dart';

class TRTextEditingManager {
  static final TRTextEditingManager _instance = TRTextEditingManager._internal();
  static TRTextEditingManager get instance => _instance;
  TRTextEditingManager._internal();

  void focusController(TRTextEditingController controller) {
    final points = getWidgetPointsWithKey(controller.key);

    final event = """
- tapOn:
    point: ${points.center.convertPercentage.toPercentageString}
- inputText: ${controller.text}
- tapOn:
    point: 90%, 90%
""";

    TestRocerderFlow.instance.recordEvent(event);
  }
}
