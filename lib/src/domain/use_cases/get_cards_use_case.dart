import 'package:blackjack/src/domain/entities/card.dart';
import 'package:blackjack/src/domain/interfaces/deck_repository.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';

class GetCardsUseCase {
  final DeckRepository _deckRepository;

  GetCardsUseCase(this._deckRepository);

  Future<Either<Failure, DeckCard>> call() async {
    final result = await _deckRepository.getCards();
    if (result.isLeft) return Left(result.left);
    return Right(result.right.first);
  }
}
