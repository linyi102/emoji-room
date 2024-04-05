import 'package:flutter/material.dart';

class KeyBoardControl {
  static void cancelKeyBoard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
