import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer_stars_investments/helpers/config.dart';
import './models/player.dart';
import './widgets/player_card.dart';
import './widgets/invest.dart';
import './models/value_log.dart';
import './helpers/utils.dart';
import './models/user.dart';

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
              headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,

            /* dark theme settings */
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _balance = 1000000;
  final User user = User();
  final TextEditingController searchController = TextEditingController();
  final List<Player> _players = [
    Player(
        name: 'Leo Messi',
        image: 'assets/images/messi.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 1000000),
          ValueLog(time: DateTime(2020), value: 1050000),
          ValueLog(time: DateTime(2021), value: 1100000)
        ],
        birthDate: DateTime(1987, 6, 24)),
    Player(
        name: 'Cristiano Ronaldo',
        image: 'assets/images/ronaldo.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 1000000),
          ValueLog(time: DateTime(2020), value: 900000),
          ValueLog(time: DateTime(2021), value: 750000)
        ],
        birthDate: DateTime(1985, 5, 2)),
    Player(
        name: 'Angel Di Maria',
        image: 'assets/images/dimaria.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 700000),
          ValueLog(time: DateTime(2020), value: 650000),
          ValueLog(time: DateTime(2021), value: 750000)
        ],
        birthDate: DateTime(1988, 2, 14)),
    Player(
        name: 'Romelu Lukaku',
        image: 'assets/images/lukaku.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 825000),
          ValueLog(time: DateTime(2020), value: 875000),
          ValueLog(time: DateTime(2021), value: 975000)
        ],
        birthDate: DateTime(1993, 5, 13)),
    Player(
        name: 'Gianluigi Donnarumma',
        image: 'assets/images/donnarumma.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 925000),
          ValueLog(time: DateTime(2020), value: 975000),
          ValueLog(time: DateTime(2021), value: 1150000)
        ],
        birthDate: DateTime(1999, 2, 25)),
    Player(
        name: 'Neymar Jr',
        image: 'assets/images/neymar.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 975000),
          ValueLog(time: DateTime(2020), value: 1000000),
          ValueLog(time: DateTime(2021), value: 975000)
        ],
        birthDate: DateTime(1992, 5, 2)),
    Player(
        name: 'Kylian Mbappe',
        image: 'assets/images/mbappe.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 1150000),
          ValueLog(time: DateTime(2020), value: 1250000),
          ValueLog(time: DateTime(2021), value: 1300000)
        ],
        birthDate: DateTime(1998, 12, 20)),
    Player(
        name: 'Leonardo Bonucci',
        image: 'assets/images/bonucci.jpg',
        recentValues: [
          ValueLog(time: DateTime(2019), value: 850000),
          ValueLog(time: DateTime(2020), value: 850000),
          ValueLog(time: DateTime(2021), value: 860000)
        ],
        birthDate: DateTime(1987, 5, 1)),
  ];
  List<Player> get _playersToShow {
    return _players
        .where((player) => player.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  int getBalance() {
    return this._balance;
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
                        player.stocks.sell(user.id);
                        _balance += moneyNet;
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
          card: PlayerCard(player: player, user: user),
          investFunction: investInPlayer,
          balance: _balance,
          user: user,
          sellNowFunc: sellNow,
        );
      },
    );
  }

  void generateNewValues() {
    for (Player p in _players) p.generateNewValue(pctRange: 15);
  }

  void investInPlayer(
      BuildContext ctx, int stocksAmount, int money, Player player) {
    HapticFeedback.mediumImpact();
    generateNewValues();
    setState(() {
      _balance -= money;
    });
    print('Investment on ${player.name}: \$${stocksAmount.toString()}');
    player.stocks
        .addStocks(stocksAmount, player.id, user.id, money ~/ stocksAmount);
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance: \$$_balance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                  controller: searchController,
                  decoration:
                      InputDecoration(hintText: 'Search player by name'),
                  onChanged: (_) {
                    setState(() {});
                  }),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView.builder(
                itemCount: _playersToShow.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: PlayerCard(
                      player: _playersToShow[index],
                      user: user,
                    ),
                    onTap: () =>
                        startInvestment(_playersToShow[index], context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
