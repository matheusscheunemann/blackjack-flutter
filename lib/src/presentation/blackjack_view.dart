import 'package:blackjack/src/presentation/blackjack_controller.dart';
import 'package:blackjack/src/presentation/blackjack_state.dart';
import 'package:blackjack/src/presentation/states/error_view.dart';
import 'package:blackjack/src/presentation/states/success_view.dart';
import 'package:blackjack/src/utils/value_notifier_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BlackjackView extends StatelessWidget {
  final _controller = GetIt.I<BlackjackController>();

  BlackjackView({super.key}) {
    _controller.getDeck();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.listenable.observer(
      builder: (_, state, ___) {
        if (state is SuccessState) {
          return SuccessView(
            anotherCardButton: _controller.anotherCard,
            nextRoundButton: _controller.nextRound,
            reshuffleButton: _controller.reshuffle,
            dealer: state.dealer,
            user: state.user,
          );
        }
        if (state is ErrorState) {
          return ErrorView(onPressed: _controller.tryAgain);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
