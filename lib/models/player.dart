import 'dart:math';
import './value_log.dart';

class Player {
  String name;
  String image;
  List<ValueLog> recentValues;

  Player({this.name, this.image, List<ValueLog> this.recentValues}) {
    if (recentValues == null) {
      recentValues = [ValueLog(), ValueLog()];
    }
  }

  int get pct {
    int newValueIndex = recentValues.length - 1;
    int newValue = recentValues[newValueIndex].value;
    int lastValue = recentValues[newValueIndex - 1].value;
    int difference = newValue - lastValue;
    return lastValue == 0 ? 0 : ((difference / lastValue) * 100).toInt();
  }
}
