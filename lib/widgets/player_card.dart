import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final String name;
  final String image;

  PlayerCard(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
          )),
          Image.asset(
            image,
            width: 125,
            height: 125,
          )
        ],
      ),
    );
  }
}
