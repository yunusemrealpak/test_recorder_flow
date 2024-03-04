import 'package:flutter/material.dart';
import 'package:test_recorder_flow/core/extensions/offset_extensions.dart';
import 'package:test_recorder_flow/core/extensions/record_extensions.dart';
import 'package:test_recorder_flow/src/extended/tr_scroll_controller.dart';
import 'package:test_recorder_flow/src/utils/helper_functions.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

enum ScrollDirection { forward, reverse, idle }

class TRScrollControllerManager {
  static final TRScrollControllerManager _instance = TRScrollControllerManager._internal();
  static TRScrollControllerManager get instance => _instance;
  TRScrollControllerManager._internal();

  final List<TRScrollController> _controllers = [];

  void registerController(TRScrollController controller) {
    _controllers.add(controller);

    Future.delayed(const Duration(seconds: 3), () {
      controller.addListener(() => _handleScroll(controller));

      checkScrollEnd(controller);
    });
  }

  Future<void> checkScrollEnd(TRScrollController controller) async {
    if (controller.scrollHasClientsCompleter == null) return;
    await controller.scrollHasClientsCompleter!.future;
    controller.position.isScrollingNotifier.addListener(() => _handleScrollingNoitifierListener(controller));
  }

  void _handleScroll(TRScrollController controller) {
    if (!controller.hasClients) {
      return;
    } else {
      if (controller.scrollHasClientsCompleter != null && !controller.scrollHasClientsCompleter!.isCompleted) {
        controller.scrollHasClientsCompleter!.complete();
      }
    }

    double currentScrollPosition = controller.position.pixels;
    ScrollDirection currentScrollDirection = currentScrollPosition > controller.lastScrollPosition ? ScrollDirection.forward : ScrollDirection.reverse;
    controller.lastScrollPosition = currentScrollPosition;

    if (controller.scrollDirection != currentScrollDirection) {
      controller.scrollDirection = currentScrollDirection;
    }
  }

  void _handleScrollingNoitifierListener(TRScrollController controller) {
    if (!controller.hasClients) return;

    if (!controller.position.isScrollingNotifier.value) {
      _handleScrollEnd(controller);
    }
  }

  void _handleScrollEnd(TRScrollController controller) {
    final points = getWidgetPoints(controller.scrollableWidgetOffset, controller.scrollableWidgetSize);

    if (controller.axisDirection == Axis.horizontal) {
      final leftCoordinates = points.left;
      final rightCoordinates = points.right;
      _addRecordedEvent(controller.axisDirection, controller.scrollDirection, leftCoordinates, rightCoordinates);
    } else {
      final topCoordinates = points.top;
      final bottomCoordinates = points.bottom;
      _addRecordedEvent(controller.axisDirection, controller.scrollDirection, topCoordinates, bottomCoordinates);
    }
  }

  void unregisterController(TRScrollController controller) {
    controller.position.removeListener(() => _handleScrollingNoitifierListener(controller));
    controller.removeListener(() => _handleScroll(controller));
    _controllers.remove(controller);
  }

  void _addRecordedEvent(Axis axisDirection, ScrollDirection direction, Offset start, Offset end) {
    final startPercentage = start.convertPercentage;
    final endPercentage = end.convertPercentage;

    final startPercentageStr = startPercentage.toPercentageString;
    final endPercentageStr = endPercentage.toPercentageString;

    String recordEvent = """
- swipe:
    start: #start
    end: #end
""";

    if (direction == ScrollDirection.forward) {
      recordEvent = recordEvent.replaceAll('#start', endPercentageStr).replaceAll('#end', startPercentageStr);
    } else if (direction == ScrollDirection.reverse) {
      recordEvent = recordEvent.replaceAll('#start', startPercentageStr).replaceAll('#end', endPercentageStr);
    }

    TestRocerderFlow.instance.recordEvent(recordEvent);
  }
}
