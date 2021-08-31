// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/data/models/qoutes.dart';
import 'package:bloc_app/data/repositery/characters_repositery.dart';
import 'chracters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> finalCharacters =[];
  List<Quote> quotesList =[];


  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      finalCharacters = characters;
    }).catchError((error) {
      print(error.toString());
    });
    return finalCharacters;
  }
  void getAllQuotes({String charName}) {
    characterRepository.getQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    }).catchError((error) {
      print(error.toString());
    });

  }
}
