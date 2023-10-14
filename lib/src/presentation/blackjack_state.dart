import 'package:blackjack/src/domain/entities/player.dart';

sealed class BlackjackState {}

class LoadingState extends BlackjackState {}

class ErrorState extends BlackjackState {}

class SuccessState extends BlackjackState {
  final Player dealer;
  final Player user;

  SuccessState({
    required this.dealer,
    required this.user,
  });
}
