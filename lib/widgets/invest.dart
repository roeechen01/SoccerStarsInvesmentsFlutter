import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/helpers/config.dart';
import 'package:soccer_stars_investments/models/stock.dart';
import 'package:soccer_stars_investments/models/user.dart';
import 'package:soccer_stars_investments/widgets/player_card.dart';
import '../helpers/utils.dart';

class Invest extends StatefulWidget {
  final PlayerCard card;
  final Function investFunction;
  final int balance;
  final User user;
  final Function sellNowFunc;

  Invest(
      {this.card,
      this.investFunction,
      this.balance,
      this.user,
      this.sellNowFunc});

  @override
  _InvestState createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  TextEditingController amountController = TextEditingController();
  int money = 0;
  List<Stock> get stocks => widget.card.player.stocks;

  int get stocksAmount => stocks.ownedStocksAmount(widget.user.id);
  int get totalSpent =>
      widget.card.player.userStocks(widget.user.id).moneySpent;
  int get stocksValue =>
      widget.card.player.value ~/
      TOTAL_STOCKS *
      stocks.ownedStocksAmount(widget.user.id);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700,
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextButton(
              onPressed: () => amountController.text != "" &&
                      amountController.text != "0" &&
                      widget.balance >= money
                  ? widget.investFunction(
                      context,
                      int.parse(amountController.text),
                      money,
                      widget.card.player)
                  : print(
                      'No input entered! / Not enough money to make investment'),
              child: Text('Invest!')),
          Row(
            children: [
              Container(
                width: 275,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (input) {
                    if (int.parse(input) > stocks.stocksLeft) {
                      amountController.text = stocks.stocksLeft.toString();
                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    }

                    setState(() {
                      if (amountController.text == "") {
                        money = 0;
                        return;
                      }
                      money = widget.card.player.value ~/
                          TOTAL_STOCKS *
                          int.parse(amountController.text);
                    });
                  },
                  decoration: InputDecoration(
                      hintText:
                          'Stocks amount (Stocks left: ${stocks.stocksLeft})'),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Price: \n\$$money',
                    style: TextStyle(
                        color: money <= widget.balance
                            ? Colors.black
                            : Colors.red),
                  ),
                ),
              )
            ],
          ),
          widget.card,
          stocks.ownedStocksAmount(widget.user.id) > 0
              ? Container(
                  child: Column(children: [
                    Text('Your stocks: $stocksAmount'),
                    Text('Paid on stocks: $totalSpent'),
                    Text('Stocks value: $stocksValue'),
                    Text('Earned in dollars: \$${stocksValue - totalSpent}'),
                    Text(
                        'Yield pct: ${(((stocksValue - totalSpent) / totalSpent) * 100).toInt()}%'),
                    FlatButton(
                        onPressed: () => widget.sellNowFunc(
                            (stocksValue * SELL_NOW_NET_RATE).toInt()),
                        child: Text(
                          'SELL NOW',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        color: Colors.yellow.shade600)
                  ]),
                )
              : Container()
        ]));
  }
}
