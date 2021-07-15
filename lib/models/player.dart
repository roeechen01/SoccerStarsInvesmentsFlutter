import 'dart:math';

class Player {
  String name;
  String image;
  int pct = -20;
  Random _rnd = new Random();

  Player(name, image) {
    this.name = name;
    this.image = image;
    pct += _rnd.nextInt(40);
  }
}
