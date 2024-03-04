import 'dart:async';

import 'package:example/core/extensions/context_extensions.dart';
import 'package:example/pages/home_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  Duration duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    Timer.periodic(duration, (t) {
      _pushToHome();
      t.cancel();
    });
  }

  void _pushToHome() {
    context.pushReplacement(const HomeView());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
