import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/models/player.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  PlayerCard(this.player);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.5),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  player.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
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
          Image.asset(
            player.image,
            width: 125,
            height: 125,
          )
        ],
      ),
    );
  }
}
