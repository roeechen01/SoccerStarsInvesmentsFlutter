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

  int ownedStocksAmount(String id) => this
      .fold(0, (counter, stock) => stock.userId == id ? counter + 1 : counter);

  int get moneySpent => this.fold(
      0,
      (totalSpent, stock) =>
          stock.lastPrice != null ? totalSpent + stock.lastPrice : totalSpent);
}
