import 'package:flutter/material.dart';
import 'package:test_recorder_flow/src/models/widget_points.dart';

WidgetPoints getWidgetPointsWithKey(GlobalKey key) {
  final widgetOffset = getWidgetOffset(key);
  final widgetSize = getWidgetSize(key);
  return getWidgetPoints(widgetOffset, widgetSize);
}

WidgetPoints getWidgetPoints(Offset widgetOffset, Size widgetSize) {
  final size = Size(widgetSize.width - 10, widgetSize.height - 10);
  final centerPoint = Offset(widgetOffset.dx + size.width / 2, widgetOffset.dy + size.height / 2);

  return WidgetPoints(
    center: centerPoint,
    top: Offset(widgetOffset.dx + size.width / 2, widgetOffset.dy),
    bottom: Offset(widgetOffset.dx + size.width / 2, widgetOffset.dy + size.height),
    left: Offset(widgetOffset.dx, widgetOffset.dy + size.height / 2),
    right: Offset(widgetOffset.dx + size.width, widgetOffset.dy + size.height / 2),
  );
}

Size getWidgetSize(GlobalKey key) {
  if (key.currentContext == null) return Size.zero;
  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  return renderBox.size;
}

Offset getWidgetOffset(GlobalKey key) {
  if (key.currentContext == null) return Offset.zero;
  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  return renderBox.localToGlobal(Offset.zero);
}
