// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rick_and_morty_app/data/models/character.dart';
import 'package:rick_and_morty_app/data/web_serviecs/characters_web_services.dart';

class CharactersRepository {
  CharactersWebServices charactersWebServices;
  CharactersRepository(
     this.charactersWebServices,
  );

  Future<List<Character>> getAllCharacters()async{
    final character=await charactersWebServices.getAllCharacters();
    return  character.map((character) => Character.fromJson(character)).toList();
  }
}
