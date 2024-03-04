import 'package:flutter/material.dart';
import 'package:test_recorder_flow/core/extensions/offset_extensions.dart';
import 'package:test_recorder_flow/core/extensions/record_extensions.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

class TestRecorderFlowWrapper extends StatefulWidget {
  final Widget child;
  const TestRecorderFlowWrapper({super.key, required this.child});

  @override
  State<TestRecorderFlowWrapper> createState() => _TestRecorderFlowWrapperState();
}

class _TestRecorderFlowWrapperState extends State<TestRecorderFlowWrapper> {
  Offset _pointerUpPosition = Offset.zero;
  Offset _pointerCancelPosition = Offset.zero;

  bool isTestRecording = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => TestRocerderFlow.setScreenSize(context));
  }

  void setTestRecording(bool value) {
    setState(() {
      isTestRecording = value;
    });
  }

  void _addRecordedEvent() {
    if (_pointerUpPosition == _pointerCancelPosition) {
      final event = """
- tapOn:
    point: ${_pointerUpPosition.convertPercentage.toPercentageString}
""";
      TestRocerderFlow.addRecordEvent(event);
    } else {
      final event = """
- swipe:
    start: ${_pointerUpPosition.convertPercentage.toPercentageString}
    end: ${_pointerCancelPosition.convertPercentage.toPercentageString}
""";
      TestRocerderFlow.addRecordEvent(event);
    }

    _pointerUpPosition = Offset.zero;
    _pointerCancelPosition = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        if (!isTestRecording) return;
        print('onPointerUp');
        _pointerUpPosition = event.position;
      },
      onPointerUp: (event) {
        if (!isTestRecording) return;
        print('onPointerCancel');
        _pointerCancelPosition = event.position;
        _addRecordedEvent();
      },
      child: Stack(
        children: [
          widget.child,
          Positioned(
              top: 60,
              right: 0,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (isTestRecording) {
                        TestRocerderFlow.saveRecordedEvents();
                      }
                      setTestRecording(!isTestRecording);
                    },
                    child: Text(isTestRecording ? 'Stop Recording' : 'Start Recording'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      TestRocerderFlow.clearRecordedEvents();
                    },
                    child: const Text('Clear Records'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
