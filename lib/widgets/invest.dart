import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/widgets/player_card.dart';

class Invest extends StatefulWidget {
  final PlayerCard card;
  final Function investFunction;

  Invest(this.card, this.investFunction);

  @override
  _InvestState createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          //card,
          TextButton(
              onPressed: () => amountController.text != ""
                  ? widget.investFunction(context,
                      int.parse(amountController.text), widget.card.player)
                  : print('No input entered!'),
              child: Text('Invest!')),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Your investment'),
          ),
        ]));
  }
}
