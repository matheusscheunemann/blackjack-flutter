import 'package:blackjack/src/domain/entities/card.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<DeckCard> cards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 500 ? 10 : 5,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) => Image.network(
              cards[index].image,
            ),
          );
        },
      ),
    );
  }
}
