import 'package:blackjack/src/domain/entities/card.dart';

class Player {
  int points;
  List<DeckCard> cards;
  int victories;

  Player({
    required this.points,
    required this.cards,
    required this.victories,
  });

  reset() {
    points = 0;
    cards = [];
  }
}
