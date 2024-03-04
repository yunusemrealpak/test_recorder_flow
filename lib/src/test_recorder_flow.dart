import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TestRocerderFlow {
  static String _apiKey = '';
  static String get apiKey => _apiKey;
  static set apiKey(String value) => _apiKey = value;

  static String _appId = '';
  static String get appId => _appId;
  static set appId(String value) => _appId = value;

  static Size _screenSize = Size.zero;
  static Size get screenSize => _screenSize;
  static void setScreenSize(BuildContext context) => _screenSize = MediaQuery.of(context).size;

  static final List<String> _recordedEvents = [];

  static void addRecordEvent(String event) {
    _recordedEvents.add(event);
  }

  static void clearRecordedEvents() {
    _recordedEvents.clear();
  }

  static List<String> get recordedEvents => _recordedEvents;

  static Future<void> saveRecordedEvents() async {
    final events = [...recordedEvents];
    events.removeLast();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/recorded_events.yaml');

    const title = """
# flow.yaml

appId: com.example.example
---
- launchApp
""";

    final eventsStr = events.map((e) => e.trim()).join('\n');

    final fileContent = '$title$eventsStr';
    await file.writeAsString(fileContent);

    final result = await Share.shareXFiles([XFile('${directory.path}/recorded_events.yaml')], text: 'Tester Records');

    if (result.status == ShareResultStatus.success) {
      debugPrint('Thank you for sharing the records!');
    }
  }
}
