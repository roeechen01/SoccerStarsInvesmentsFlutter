import 'package:flutter/material.dart';
import 'package:soccer_stars_investments/main.dart';

class BuyCoinsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text('Current balance: ${MyHomePage().balance}')),
      ],
    );
  }
}
