import 'package:blackjack/src/domain/entities/player.dart';
import 'package:blackjack/src/presentation/widgets/cards_grid_view.dart';
import 'package:blackjack/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  final void Function() anotherCardButton;
  final void Function() nextRoundButton;
  final void Function() reshuffleButton;
  final Player dealer;
  final Player user;

  const SuccessView({
    super.key,
    required this.anotherCardButton,
    required this.nextRoundButton,
    required this.reshuffleButton,
    required this.dealer,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF35654d),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Pontos da mesa: ${dealer.points}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: defineColor(dealer.points),
                    ),
                  ),
                  Text(
                    "Vitórias: ${dealer.victories}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            CardsGridView(cards: dealer.cards),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Seus pontos: ${user.points}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: defineColor(user.points),
                    ),
                  ),
                  Text(
                    'Vitórias: ${user.victories}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            CardsGridView(cards: user.cards),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: anotherCardButton,
                  label: "Puxar carta",
                ),
                const SizedBox(width: 40),
                CustomButton(
                  onPressed: nextRoundButton,
                  label: "Próximo round",
                ),
                const SizedBox(width: 40),
                CustomButton(
                  onPressed: reshuffleButton,
                  label: "Embaralhar cartas",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color defineColor(int points) {
    if (points > 21) return Colors.red;
    if (points == 21) return Colors.green;
    return Colors.black;
  }
}
