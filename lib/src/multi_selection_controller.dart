import 'package:flutter/material.dart';

class MultiSelectController {
   VoidCallback? clearSelectionCallback;

  MultiSelectController({this.clearSelectionCallback});

  void clearSelection() {
    if (clearSelectionCallback != null) {
      clearSelectionCallback!();
    }
  }
}

