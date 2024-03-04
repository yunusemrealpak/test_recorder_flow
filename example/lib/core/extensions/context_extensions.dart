import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void push(Widget view) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  void pushReplacement(Widget view) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => view,
      ),
      (route) => false,
    );
  }
}
