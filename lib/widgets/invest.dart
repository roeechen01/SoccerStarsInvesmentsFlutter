import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/helpers/config.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700,
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextButton(
              onPressed: () =>
                  amountController.text != "" && widget.balance >= money
                      ? widget.investFunction(
                          context,
                          int.parse(amountController.text),
                          money,
                          widget.card.player)
                      : print('No input entered!'),
              child: Text('Invest!')),
          Row(
            children: [
              Container(
                width: 300,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    setState(() {
                      money = widget.card.player.value ~/
                          TOTAL_STOCKS *
                          int.parse(amountController.text);
                      print(money);
                    });
                  },
                  decoration: InputDecoration(
                      hintText:
                          'Stocks amount (Stocks left: ${widget.card.player.stocks.stocksLeft})'),
                ),
              ),
              Text(
                '\$$money',
                style: TextStyle(
                    color: money <= widget.balance ? Colors.black : Colors.red),
              )
            ],
          ),
          widget.card
        ]));
  }
}
