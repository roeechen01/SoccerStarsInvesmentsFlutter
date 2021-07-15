import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  String name;
  String image;

  PlayerCard(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
              child: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
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
