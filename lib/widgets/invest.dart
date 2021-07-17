import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/helpers/config.dart';
import 'package:soccer_stars_investments/models/stock.dart';
import 'package:soccer_stars_investments/widgets/player_card.dart';
import '../helpers/utils.dart';

class Invest extends StatefulWidget {
  final PlayerCard card;
  final Function investFunction;
  final int balance;

  Invest(this.card, this.investFunction, this.balance);

  @override
  _InvestState createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  TextEditingController amountController = TextEditingController();
  int money = 0;
  List<Stock> get stocks => widget.card.player.stocks;

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
                  onChanged: (_) {
                    if (int.parse(_) > stocks.stocksLeft) {
                      amountController.text = stocks.stocksLeft.toString();
                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    }

                    setState(() {
                      money = widget.card.player.value ~/
                          TOTAL_STOCKS *
                          int.parse(amountController.text);
                      print(money);
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
          widget.card
        ]));
  }
}
