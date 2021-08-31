// @dart=2.9

import 'package:bloc_app/constants/strings.dart';
import 'package:bloc_app/data/repositery/characters_repositery.dart';
import 'package:bloc_app/data/web_services/character_api.dart';
import 'package:bloc_app/presentation/screens/characters_details.dart';
import 'package:bloc_app/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'business_logic/cubit/chracters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/characters_model.dart';

class AppRouter {
  CharacterRepository characterRepository;
  CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository =
        CharacterRepository(charWebServices: CharWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: Home(),
                ));
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create:  (BuildContext context) => CharactersCubit(characterRepository),
                    child: CharacterDetailsScreen(
                  character: character,

                )));
    }
  }
}
