import 'package:blackjack/src/domain/entities/deck.dart';
import 'package:blackjack/src/domain/interfaces/deck_repository.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';

class ReshuffleUseCase {
  final DeckRepository _deckRepository;

  ReshuffleUseCase(this._deckRepository);

  Future<Either<Failure, Deck>> call() async {
    final result = await _deckRepository.reshuffle();
    if (result.isLeft) return Left(result.left);
    return Right(result.right);
  }
}
