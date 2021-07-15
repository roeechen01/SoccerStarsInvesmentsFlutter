import 'package:flutter/material.dart';
import './models/player.dart';
import './widgets/player_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Balance: \$$_balance'),
        ),
        body: ListView.builder(
          itemCount: _players.length,
          itemBuilder: (context, index) {
            return PlayerCard(_players[index].name, _players[index].image);
          },
        ));
  }
}
