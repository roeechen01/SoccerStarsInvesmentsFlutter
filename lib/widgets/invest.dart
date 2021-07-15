import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/widgets/player_card.dart';

class Invest extends StatelessWidget {
  final PlayerCard card;
  TextEditingController amountController = TextEditingController();
  final Function investFunction;

  Invest(this.card, this.investFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusScopeNode currentFocus = FocusScope.of(context);
        //if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus &&
        //     currentFocus.focusedChild != null) {
        //   currentFocus.focusedChild.unfocus();
        // }

        // FocusManager.instance.primaryFocus.unfocus();
      },
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            //card,
            TextButton(
                onPressed: () => investFunction(
                    int.parse(amountController.text), card.player),
                child: Text('Invest!')),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              //TextInputType.numberWithOptions(decimal: false, signed: false),
              //textInputAction: TextInputAction.send,
              decoration: InputDecoration(hintText: 'Your investment'),
            ),
          ])),
    );
  }
}
