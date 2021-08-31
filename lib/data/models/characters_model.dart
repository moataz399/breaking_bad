// @dart=2.9

class Character {

  int charId;
  String name;
  String nickName;
  String image;
  List<dynamic> jobs;
  String status;
  List<dynamic> appearance;
  String actorName;

  String categoryForTwoSeries;

  List<dynamic> betterCallSaulAppearance;


  Character.fromJson(Map <String, dynamic> json){
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    status = json['status'];
    appearance = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }

}