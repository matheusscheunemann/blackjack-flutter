import 'package:blackjack/src/domain/entities/deck.dart';
import 'package:blackjack/src/domain/interfaces/deck_repository.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';

class GetDeckUseCase {
  final DeckRepository _deckRepository;

  GetDeckUseCase(this._deckRepository);

  Future<Either<Failure, Deck>> call() async {
    final result = await _deckRepository.getDeck();
    if (result.isLeft) return Left(result.left);
    return Right(result.right);
  }
}
