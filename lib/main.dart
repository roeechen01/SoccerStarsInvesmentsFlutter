import 'package:flutter/material.dart';
import './models/player.dart';
import './widgets/player_card.dart';
import './widgets/invest.dart';
import './models/value_log.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          home: MyHomePage(),
          theme: ThemeData(
              textTheme: TextTheme(
                  headline6:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _balance = 1000000;
  final List<Player> _players = [
    Player(name: 'Leo Messi', image: 'assets/images/messi.jpg', recentValues: [
      ValueLog(time: DateTime(2019), value: 1000000),
      ValueLog(time: DateTime(2021), value: 1200000)
    ]),
    Player(
        name: 'Cristiano Ronaldo',
        image: 'assets/images/ronaldo.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 1000000),
          ValueLog(time: DateTime(2020), value: 900000),
          ValueLog(time: DateTime(2021), value: 750000)
        ]),
    Player(name: 'Angel Di Maria', image: 'assets/images/dimaria.jpg'),
    Player(name: 'Romelu Lukaku', image: 'assets/images/lukaku.jpg'),
    Player(name: 'Gianluigi Donnarumma', image: 'assets/images/donnarumma.jpg'),
    Player(name: 'Neymar Jr', image: 'assets/images/neymar.jpg'),
    Player(name: 'Kylian Mbappe', image: 'assets/images/mbappe.jpg'),
    Player(name: 'Leonardo Bonucci', image: 'assets/images/bonucci.jpg'),
  ];

  void startInvestment(Player player, BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) {
        return Invest(PlayerCard(player), investInPlayer);
      },
    );
  }

  void investInPlayer(BuildContext ctx, var amount, Player player) {
    setState(() {
      _balance -= amount;
    });
    print('Investment on ${player.name}: \$${amount.toString()}');
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Balance: \$$_balance'),
        ),
        body: ListView.builder(
          itemCount: _players.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: PlayerCard(_players[index]),
              onTap: () => startInvestment(_players[index], context),
            );
          },
        ));
  }
}
