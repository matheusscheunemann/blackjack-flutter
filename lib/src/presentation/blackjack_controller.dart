import 'package:blackjack/src/domain/entities/card.dart';
import 'package:blackjack/src/domain/entities/player.dart';
import 'package:blackjack/src/domain/use_cases/get_cards_use_case.dart';
import 'package:blackjack/src/domain/use_cases/get_deck_use_case.dart';
import 'package:blackjack/src/domain/use_cases/reshuffle_use_case.dart';
import 'package:blackjack/src/presentation/blackjack_state.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';
import 'package:flutter/foundation.dart';

class BlackjackController {
  final GetDeckUseCase _getDeck;
  final GetCardsUseCase _getCardsUseCase;
  final ReshuffleUseCase _reshuffleUseCase;
  final ValueNotifier<BlackjackState> _notifier;

  BlackjackController(
    this._getDeck,
    this._getCardsUseCase,
    this._reshuffleUseCase,
  ) : _notifier = ValueNotifier(LoadingState());

  ValueListenable<BlackjackState> get listenable => _notifier;

  Player dealer = Player(points: 0, cards: [], victories: 0);
  Player user = Player(points: 0, cards: [], victories: 0);

  Future<void> getDeck() async {
    _notifier.value = LoadingState();
    final result = await _getDeck();
    if (result.isLeft) {
      _notifier.value = ErrorState();
      return;
    }

    _notifier.value = SuccessState(
      dealer: dealer,
      user: user,
    );
    Future.delayed(
      const Duration(milliseconds: 100),
      () async => await _addCard(dealer),
    );
  }

  Future<void> reshuffle() async {
    _notifier.value = LoadingState();
    final result = await _reshuffleUseCase();
    if (result.isLeft) {
      _notifier.value = ErrorState();
      return;
    }
    _notifier.value = SuccessState(
      dealer: dealer,
      user: user,
    );
  }

  Future<Either<Failure, DeckCard>> getCard() async {
    final result = await _getCardsUseCase();
    if (result.isLeft) {
      _notifier.value = ErrorState();
      return Left(result.left);
    }
    return Right(result.right);
  }

  Future<void> anotherCard() async {
    await _addCard(user);
    Future.delayed(
      const Duration(milliseconds: 100),
      () async => await _addCard(dealer),
    );
  }

  Future<void> _addCard(Player player) async {
    if (user.points < 21 && dealer.points < 21) {
      final result = await getCard();
      player.points = player.points + result.right.value;
      player.cards.add(result.right);
      verifyWinner();
      _notifier.value = SuccessState(
        dealer: dealer,
        user: user,
      );
    }
  }

  verifyWinner() {
    if (user.points > 21 || dealer.points == 21) dealer.victories++;
    if (dealer.points > 21 || user.points == 21) user.victories++;
  }

  void nextRound() {
    dealer.reset();
    user.reset();
    _notifier.value = SuccessState(
      dealer: dealer,
      user: user,
    );
    Future.delayed(
      const Duration(milliseconds: 100),
      () async => await _addCard(dealer),
    );
  }

  Future<void> tryAgain() async {
    dealer.reset();
    user.reset();
    await getDeck();
  }
}
