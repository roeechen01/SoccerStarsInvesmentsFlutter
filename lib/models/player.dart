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
    if (recentValues == null) {
      recentValues = [ValueLog(), ValueLog()];
    }
    if (birthDate == null) birthDate = DateTime(1985);
    initiateStocks();
    if (this.id == null) this.id = Uuid().v4();
  }

  void initiateStocks() {
    for (int i = 0; i < TOTAL_STOCKS; i++) {
      stocks.add(Stock());
    }
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
