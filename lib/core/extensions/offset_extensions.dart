import 'package:flutter/material.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

extension TROffsetExtensions on Offset {
  (int, int) get convertPercentage {
    final size = TestRocerderFlow.instance.screenSize;
    final percentageX = 100 * dx / size.width;
    final percentageY = 100 * dy / size.height;

    return (percentageX.round(), percentageY.round());
  }
}
