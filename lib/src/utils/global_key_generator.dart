import 'package:flutter/material.dart';

class GlobalKeyGenerator {
  static final GlobalKeyGenerator _instance = GlobalKeyGenerator._internal();
  static GlobalKeyGenerator get instance => _instance;
  GlobalKeyGenerator._internal();

  GlobalKey createKey() {
    return GlobalKey();
  }
}
