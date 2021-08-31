// @dart=2.9

import 'package:bloc_app/constants/my_colors.dart';
import 'package:bloc_app/constants/strings.dart';
import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/presentation/screens/characters_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  CharacterItem({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){Navigator.pushNamed(context,characterDetailsScreen,arguments: character);},
        child: GridTile(
            footer: Hero(
              tag: character.charId,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  character.name,
                  style: TextStyle(
                      height: 1.3,
                      fontSize: 16,
                      color: MyColors.myWhite,
                      fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,

                ),
              ),
            ),
            child: Container(
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image)
                  : Image.asset('assets/images/shop.png'),
              color: MyColors.myGrey,
            )),
      ),
    );
  }
}
