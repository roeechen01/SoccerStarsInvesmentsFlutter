import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer_stars_investments/main.dart';
import 'package:soccer_stars_investments/models/player.dart';
import 'package:soccer_stars_investments/models/user.dart';
import 'package:soccer_stars_investments/widgets/invest.dart';
import 'package:soccer_stars_investments/widgets/player_card.dart';
import '../helpers/utils.dart';

import '../helpers/config.dart';

class MyAssetsScreen extends StatefulWidget {
  List<Player> players;

  MyAssetsScreen(this.players);

  @override
  _MyAssetsScreenState createState() => _MyAssetsScreenState();
}

class _MyAssetsScreenState extends State<MyAssetsScreen> {
  void generateNewValues() {
    for (Player p in widget.players) p.generateNewValue(pctRange: 15);
  }

  void investInPlayer(
      BuildContext ctx, int stocksAmount, int money, Player player) {
    HapticFeedback.mediumImpact();
    generateNewValues();
    setState(() {
      MyHomePage().balance -= money;
    });
    print('Investment on ${player.name}: \$${stocksAmount.toString()}');
    player.stocks
        .addStocks(stocksAmount, player.id, User().id, money ~/ stocksAmount);
    Navigator.pop(ctx);
  }

  void sellNow(int moneyNet, Player player) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sell Now?"),
            content: Text(
                "Based on current commission (${(COMMISSION_RATE * 100).toInt()}%)\nYou will earn \$$moneyNet"),
            actions: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Sell",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                      setState(() {
                        player.stocks.sell(User().id);
                        MyHomePage().balance += moneyNet;
                        generateNewValues();
                      });
                    },
                  )
                ],
              )
            ],
          );
        });
  }

  void startInvestment(Player player, BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (ctx) {
        return Invest(
          card: PlayerCard(player: player, user: User()),
          investFunction: investInPlayer,
          balance: MyHomePage().balance,
          user: User(),
          sellNowFunc: sellNow,
        );
      },
    );
  }

  List<Player> get _playersToShow {
    return widget.players
        .where((player) => player.stocks.ownedStocksAmount(User().id) > 0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Assets'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            (AppBar().preferredSize.height + 100),
        child: ListView.builder(
          itemCount: _playersToShow.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: PlayerCard(
                player: _playersToShow[index],
                user: User(),
              ),
              onTap: () => startInvestment(_playersToShow[index], context),
            );
          },
        ),
      ),
    );
  }
}
