import 'package:soccer_stars_investments/helpers/utils.dart';
import './value_log.dart';
import './stock.dart';
import '../helpers/config.dart';

class Player {
  String name;
  String image;
  DateTime birthDate;
  List<ValueLog> recentValues;
  int get value => recentValues.last.value;

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

  int get age => birthDate.asAge;

  @override
  String toString() {
    return this.name;
  }
}
