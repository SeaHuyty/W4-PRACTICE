import 'package:flutter/material.dart';

enum CardType {
  red(Colors.red),
  blue(Colors.blue),
  pink(Colors.pink),
  orange(Colors.orange);

  final Color color;

  const CardType(this.color);
}

class ColorService extends ChangeNotifier {

 Map<CardType, int> tapCount = {};

  ColorService() {
    for(final CardType type in CardType.values) {
      tapCount[type] = 0;
    }
  }

  int getTapCount(CardType type) {
    return tapCount[type] ?? 0;
  }

  void increaseTap(CardType type) {
    tapCount[type] = getTapCount(type) + 1;

    notifyListeners();
  }
}