import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:test_recorder_flow/src/managers/tr_scroll_controller_manager.dart';
import 'package:test_recorder_flow/src/utils/helper_functions.dart';

/// A custom scroll controller that extends the [ScrollController] class.
/// This controller is used to register and unregister itself with the [TRScrollControllerManager].
class TRScrollController extends ScrollController {
  GlobalKey? key;
  Offset scrollableWidgetOffset = Offset.zero;
  Size scrollableWidgetSize = Size.zero;
  Axis axisDirection = Axis.vertical;
  ScrollDirection scrollDirection = ScrollDirection.idle;
  double lastScrollPosition = 0;

  Completer<void>? scrollHasClientsCompleter;

  TRScrollController() : super() {
    scrollHasClientsCompleter = Completer<void>();
    TRScrollControllerManager.instance.registerController(this);
  }

  void setKey(GlobalKey key, Axis direction) {
    this.key = key;
    axisDirection = direction;
    scrollableWidgetSize = getWidgetSize(key);
    scrollableWidgetOffset = getWidgetOffset(key);
  }

  set scrollDirectionSetter(ScrollDirection direction) {
    scrollDirection = direction;
  }

  set lastScrollPositionSetter(double position) {
    lastScrollPosition = position;
  }

  @override
  void dispose() {
    scrollHasClientsCompleter = null;
    TRScrollControllerManager.instance.unregisterController(this);
    super.dispose();
  }
}
