import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/models/player.dart';
import 'package:soccer_stars_investments/models/user.dart';
import '../helpers/utils.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final User user;
  PlayerCard({this.player, this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                    player.image,
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.5),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          player.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: player.stocks.ownedStocksAmount(user.id) > 0
                              ? Icon(Icons.monetization_on)
                              : Text(''),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        'Value: \$${player.value.stringWithCommas()}',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text('Age: ${player.age}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('${player.pct}%'),
                  player.pct > 0
                      ? Icon(
                          Icons.arrow_circle_up,
                          color: Colors.green,
                          size: 40,
                        )
                      : Icon(
                          Icons.arrow_circle_down,
                          color: Colors.red,
                          size: 40,
                        ),
                ],
              )),
        ],
      ),
    );
  }
}
