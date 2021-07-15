import 'package:flutter/material.dart';
import './models/player.dart';
import './widgets/player_card.dart';
import './widgets/invest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          textTheme: TextTheme(
              headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _balance = 1000000;
  final List<Player> _players = [
    Player('Leo Messi', 'assets/images/messi.jpg'),
    Player('Cristiano Ronaldo', 'assets/images/ronaldo.jpg'),
    Player('Angel Di Maria', 'assets/images/dimaria.jpg'),
    Player('Romelu Lukaku', 'assets/images/lukaku.jpg'),
    Player('Gianluigi Donnarumma', 'assets/images/donnarumma.jpg'),
    Player('Neymar Jr', 'assets/images/neymar.jpg'),
    Player('Kylian Mbappe', 'assets/images/mbappe.jpg'),
    Player('Leonardo Bonucci', 'assets/images/bonucci.jpg'),
  ];

  void startInvestment(Player player, BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) {
        return Invest(PlayerCard(player), investInPlayer);
      },
    );
  }

  void investInPlayer(int amount, Player player) {
    setState(() {
      _balance -= amount;
    });
    print('Investment on ${player.name}: \$${amount.toString()}');
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
