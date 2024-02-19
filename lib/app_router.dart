import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_serviecs/characters_web_services.dart';
import 'presentation/screens/character_screen.dart';
import 'presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: const CharacterScreen()));
      case characterDetailsScreen:
      final character=settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>  DetailsScreen(character: character));
    }
    return null;
  }
}
