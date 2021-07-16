import 'dart:math';
import './value_log.dart';

class Player {
  String name;
  String image;
  DateTime birthDate;
  List<ValueLog> recentValues;

  Player({this.name, this.image, this.birthDate, this.recentValues}) {
    if (recentValues == null) {
      recentValues = [ValueLog(), ValueLog()];
    }
    if (birthDate == null) birthDate = DateTime(1985);
  }

  int get pct {
    int newValueIndex = recentValues.length - 1;
    int newValue = recentValues[newValueIndex].value;
    int lastValue = recentValues[newValueIndex - 1].value;
    int difference = newValue - lastValue;
    return lastValue == 0 ? 0 : ((difference / lastValue) * 100).toInt();
  }

  int get age {
    int years = DateTime.now().year - birthDate.year;
    int months = DateTime.now().month - birthDate.month;
    int days = DateTime.now().day - birthDate.day;

    return ((months > 0) || (months == 0 && days >= 0)) ? years : years - 1;
  }
}
