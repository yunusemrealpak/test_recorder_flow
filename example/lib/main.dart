import 'package:example/pages/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TestRocerderFlow.instance.setScreenSize(context);
    return const MaterialApp(home: SplashView());
  }
}
