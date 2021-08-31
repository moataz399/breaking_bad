// @dart=2.9

import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/data/models/qoutes.dart';
import 'package:bloc_app/data/web_services/character_api.dart';
import 'package:characters/characters.dart';
import 'package:flutter/cupertino.dart';
import '';

class CharacterRepository {
  CharWebServices charWebServices;

  CharacterRepository({@required this.charWebServices});

  Future<List<Character>> getAllCharacters() async {
    var characters = await charWebServices.getAllCharacters();

    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getQuotes(String charName) async {
    final quotes = await charWebServices.getQuotes(charName);

    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }
}
