import 'dart:math';

import 'package:soccer_stars_investments/helpers/utils.dart';
import './value_log.dart';
import './stock.dart';
import '../helpers/config.dart';
import 'package:uuid/uuid.dart';

class Player {
  String id;
  String name;
  String image;
  DateTime birthDate;
  List<ValueLog> recentValues;
  List<Stock> stocks = List<Stock>();

  int get value => recentValues.last.value;

  Player({this.name, this.image, this.birthDate, this.recentValues, this.id}) {
    if (birthDate == null) birthDate = DateTime(1985);
    initiateStocks();
    if (this.id == null) this.id = Uuid().v4();
    if (recentValues == null)
      recentValues = [ValueLog(), ValueLog()];
    else
      setRecentValuesByDate();
    //generateNewValue();
  }

  void setRecentValuesByDate() {
    List<ValueLog> values = List<ValueLog>();

    for (int i = 0; i < recentValues.length; i++) {
      ValueLog min = recentValues[0];
      for (int j = 0; j < recentValues.length; j++) {
        if (min.time.isAfter(recentValues[j].time)) min = recentValues[j];
      }
      values.add(ValueLog(time: min.time, value: min.value));
      min.time = DateTime.now();
    }
    recentValues = values;
  }

  void initiateStocks() {
    for (int i = 0; i < TOTAL_STOCKS; i++) {
      stocks.add(Stock());
    }
  }

  void generateNewValue({int pctRange}) {
    if (pctRange == null) pctRange = 10;
    Random rnd = Random();
    double rndNum = -pctRange + rnd.nextInt(pctRange * 2).toDouble();
    recentValues.add(ValueLog(
        time: DateTime.now(), value: (value * (1 + rndNum / 100)).toInt()));
  }

  int get pct {
    int newValueIndex = recentValues.length - 1;
    int newValue = recentValues[newValueIndex].value;
    int lastValue = recentValues[newValueIndex - 1].value;
    int difference = newValue - lastValue;
    return lastValue == 0 ? 0 : ((difference / lastValue) * 100).toInt();
  }

  List<Stock> userStocks(String id) =>
      stocks.where((stock) => stock.userId == id).toList();

  int get age => birthDate.asAge;

  @override
  String toString() {
    return this.name;
  }
}
