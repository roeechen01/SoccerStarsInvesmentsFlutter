import 'package:soccer_stars_investments/models/stock.dart';
import './config.dart';

extension RoeeDateTime on DateTime {
  int get asAge {
    int years = DateTime.now().year - this.year;
    int months = DateTime.now().month - this.month;
    int days = DateTime.now().day - this.day;

    return ((months > 0) || (months == 0 && days >= 0)) ? years : years - 1;
  }
}

extension RoeeInt on int {
  String stringWithCommas() {
    if (this == 0) return '0';
    int number = this;
    List<String> chars = List<String>();
    while (number > 0) {
      chars.add((number % 10).toString());
      number ~/= 10;
    }
    int commaTime = 0;
    for (int i = 0; i < chars.length; i++) {
      commaTime++;
      if (commaTime == 4) {
        commaTime = 0;
        chars.insert(i, ',');
      }
    }
    return chars.reversed.fold("", (finalString, char) => finalString + char);
  }
}

extension RoeeList on List {
  void printList() {
    for (int i = 0; i < this.length; i++) {
      print(this[i]);
    }
  }
}

extension RoeeStockList on List<Stock> {
  static int totalStocks = TOTAL_STOCKS;

  int get stocksLeft {
    return this.fold(0, (amount, stock) {
      if (stock.userId == null) return ++amount;
      return amount;
    });
  }

  void addStocks(int amount, String playerId, String userId, int lastPrice) {
    if (amount > this.stocksLeft) {
      print('Not enough available stocks to make the investment');
      return;
    }
    for (int i = 0; i < TOTAL_STOCKS; i++) {
      if (amount == 0) return;
      if (this[i].userId == null) {
        this[i].playerId = playerId;
        this[i].userId = userId;
        this[i].lastPrice = lastPrice;
        amount--;
      }
    }
  }

  void sell(String id, {int stocksToSell}) {
    if (stocksToSell == null) {
      for (Stock stock in this) {
        if (stock.userId == id) {
          stock.userId = null;
          stock.lastPrice = null;
        }
      }
    } else {
      int counter = stocksToSell;
      for (int i = 0; i < stocksToSell; i++) {
        if (this[i].userId == id) {
          this[i].userId = null;
          this[i].lastPrice = null;
          counter--;
          if (counter == 0) return;
        }
      }
    }
  }

  int ownedStocksAmount(String id) => this
      .fold(0, (counter, stock) => stock.userId == id ? counter + 1 : counter);

  int get moneySpent => this.fold(
      0,
      (totalSpent, stock) =>
          stock.lastPrice != null ? totalSpent + stock.lastPrice : totalSpent);
}
