// @dart=2.9

class Quote{
  String quote;
  Quote.fromJson(Map <String,dynamic> json){

    quote=json['quote'];
  }
}