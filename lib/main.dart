import 'package:blackjack/src/domain/interfaces/deck_repository.dart';
import 'package:blackjack/src/domain/use_cases/get_cards_use_case.dart';
import 'package:blackjack/src/domain/use_cases/get_deck_use_case.dart';
import 'package:blackjack/src/domain/use_cases/reshuffle_use_case.dart';
import 'package:blackjack/src/infra/deck_repository.dart';
import 'package:blackjack/src/presentation/blackjack_controller.dart';
import 'package:blackjack/src/presentation/blackjack_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlackjackView(),
    );
  }
}

void initialize() {
  //infra
  GetIt.I.registerSingleton<DeckRepository>(DeckRepositoryImpl(Dio()));

  //domain
  GetIt.I.registerFactory<GetCardsUseCase>(
    () => GetCardsUseCase(
      GetIt.I<DeckRepository>(),
    ),
  );
  GetIt.I.registerFactory<GetDeckUseCase>(
    () => GetDeckUseCase(
      GetIt.I<DeckRepository>(),
    ),
  );
  GetIt.I.registerFactory<ReshuffleUseCase>(
    () => ReshuffleUseCase(
      GetIt.I<DeckRepository>(),
    ),
  );

  //presentation
  GetIt.I.registerFactory<BlackjackController>(
    () => BlackjackController(
      GetIt.I<GetDeckUseCase>(),
      GetIt.I<GetCardsUseCase>(),
      GetIt.I<ReshuffleUseCase>(),
    ),
  );
}
