import 'package:test_recorder_flow/core/extensions/offset_extensions.dart';
import 'package:test_recorder_flow/core/extensions/record_extensions.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

import '../utils/helper_functions.dart';

class TRTextEditingManager {
  static final TRTextEditingManager _instance = TRTextEditingManager._internal();
  static TRTextEditingManager get instance => _instance;
  TRTextEditingManager._internal();

  void focusController(TRTextEditingController controller) {
    final event = """
- inputText: ${controller.text}
- tapOn:
    point: 90%, 90%
""";

    TestRocerderFlow.addRecordEvent(event);
  }
}
