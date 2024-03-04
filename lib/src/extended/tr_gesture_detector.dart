import 'package:flutter/widgets.dart';
import 'package:test_recorder_flow/src/managers/tr_gesture_detector_manager.dart';
import 'package:test_recorder_flow/src/utils/global_key_generator.dart';

class TRGestureDetector extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  TRGestureDetector({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key ?? GlobalKeyGenerator.instance.createKey());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TRGestureDetectorManager.instance.onTap(key! as GlobalKey);
        onTap?.call();
      },
      child: child,
    );
  }
}
