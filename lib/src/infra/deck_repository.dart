import 'package:blackjack/src/domain/entities/card.dart';
import 'package:blackjack/src/domain/entities/deck.dart';
import 'package:blackjack/src/domain/interfaces/deck_repository.dart';
import 'package:blackjack/src/utils/either.dart';
import 'package:blackjack/src/utils/failure.dart';
import 'package:dio/dio.dart';

class DeckRepositoryImpl implements DeckRepository {
  final Dio dio;

  DeckRepositoryImpl(this.dio);

  static const String deckEndpoint = 'https://www.deckofcardsapi.com/api/deck';
  String? deckId;

  @override
  Future<Either<Failure, Deck>> getDeck() async {
    try {
      final response = await dio.get('$deckEndpoint/new/shuffle/?deck_count=1');
      final deck = Deck.fromJson(response.data);
      if (deck.success == false) {
        return Left(GenericFailure());
      }
      deckId = deck.id;
      return Right(deck);
    } on DioException {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<DeckCard>>> getCards() async {
    try {
      final response = await dio.get('$deckEndpoint/$deckId/draw/?count=1');
      final list = List<DeckCard>.from((response.data?['cards'] ?? [])
          .map<DeckCard>((card) => DeckCard.fromJson(card)));
      if (response.data['remaining'] == 0) await getDeck();
      return Right(list);
    } on DioException {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Deck>> reshuffle() async {
    try {
      final response = await dio.get('$deckEndpoint/$deckId/shuffle');
      return Right(Deck.fromJson(response.data));
    } on DioException {
      return Left(GenericFailure());
    }
  }
}
