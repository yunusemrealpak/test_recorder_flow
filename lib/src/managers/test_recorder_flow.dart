import 'package:flutter/material.dart';

class TestRocerderFlow {
  static final TestRocerderFlow _instance = TestRocerderFlow._internal();
  static TestRocerderFlow get instance => _instance;
  TestRocerderFlow._internal();

  String _apiKey = '';
  String get apiKey => _apiKey;
  set apiKey(String value) => _apiKey = value;

  String _appId = '';
  String get appId => _appId;
  set appId(String value) => _appId = value;

  Size _screenSize = Size.zero;
  Size get screenSize => _screenSize;
  void setScreenSize(BuildContext context) => _screenSize = MediaQuery.of(context).size;

  final List<String> _recordedEvents = [];

  void recordEvent(String event) {
    _recordedEvents.add(event);
  }

  void clearRecordedEvents() {
    _recordedEvents.clear();
  }

  List<String> get recordedEvents => _recordedEvents;
}
