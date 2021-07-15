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
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _balance = 1000000;
  // List<Map<String, Object>> _players = [
  //   {'name': 'Leo Messi', 'image': 'assets/images/messi.jpg'},
  //   {'name': 'Cristiano Ronaldo', 'image': 'assets/images/ronaldo.jpg'}
  // ];
  List<Player> _players = [
    Player('Leo Messi', 'assets/images/messi.jpg'),
    Player('Cristiano Ronaldo', 'assets/images/ronaldo.jpg')
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
