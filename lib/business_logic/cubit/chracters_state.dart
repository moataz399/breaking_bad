// @dart=2.9


import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/data/models/qoutes.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState{

  final List <Character> characters;

  CharactersLoaded(this.characters);
}


class QuotesLoaded extends CharactersState{

  final List <Quote> quotes;

  QuotesLoaded(this.quotes);
}
