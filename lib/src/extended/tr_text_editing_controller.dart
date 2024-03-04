import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_recorder_flow/src/utils/global_key_generator.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

class TRTextEditingController extends TextEditingController {
  TRTextEditingController({Key? key, super.text, FocusNode? focusNode}) : _focusNode = focusNode ?? FocusNode() {
    if (key != null) {
      assert(key is GlobalKey, 'TRTextEditingController key must be a GlobalKey');
    }

    if (key == null) {
      this.key = GlobalKeyGenerator.instance.createKey();
    } else {
      this.key = key as GlobalKey;
    }

    init();
  }

  late GlobalKey key;

  late final FocusNode _focusNode;
  FocusNode get focusNode => _focusNode;

  bool _isFocused = false;

  void init() {
    _focusNode.addListener(_focusNodeListener);
  }

  void _focusNodeListener() {
    if (_focusNode.hasFocus) {
      _isFocused = true;
    }

    if (!_focusNode.hasFocus && _isFocused) {
      _isFocused = false;
      TRTextEditingManager.instance.focusController(this);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    _focusNode.dispose();
    super.dispose();
  }
}
