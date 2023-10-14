import 'package:blackjack/src/domain/entities/card.dart';
import 'package:blackjack/src/domain/entities/deck.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';

abstract class DeckRepository {
  Future<Either<Failure, Deck>> getDeck();
  Future<Either<Failure, List<DeckCard>>> getCards();
  Future<Either<Failure, Deck>> reshuffle();
}
