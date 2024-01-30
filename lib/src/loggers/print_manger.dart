import 'package:flutter/foundation.dart';

import 'colored_print.dart';

class PrintManager {
  static void printFullText(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static void printItem({
    required dynamic item,
    bool printFirst = true,
  }) {
    if (kDebugMode) {
      if (printFirst == true) {
        print(AppStringsManager.printEqual);
      }
      print(item.toString());
      print(AppStringsManager.printEqual);
    }
  }

  static void printColoredText({
    required dynamic item,
    required ConsoleColor color,
    bool printFirst = true,
  }) {
    final colorCode = ColoredPrint.colorCodes[color];
    if (colorCode != null) {
      if (printFirst == true) {
        print(AppStringsManager.printEqual);
      }
      print('$colorCode$item${ColoredPrint.colorCodes[ConsoleColor.reset]}');
      print(AppStringsManager.printEqual);
    } else {
      print(item);
      print(AppStringsManager.printEqual);
    }
  }
}
class AppStringsManager {
  static const printEqual = "══════════════════════════════════════════════>>";
  static const printEqual2 =
      "──────────────────────────────────────────────────────────────────────";
}
