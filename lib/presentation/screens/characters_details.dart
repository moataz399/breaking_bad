// @dart=2.9

import 'dart:math';

import 'package:bloc_app/business_logic/cubit/chracters_cubit.dart';
import 'package:bloc_app/business_logic/cubit/chracters_state.dart';
import 'package:bloc_app/constants/my_colors.dart';
import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/data/models/qoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({this.character});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getAllQuotes(charName: character.name);
    return Scaffold(
          backgroundColor: MyColors.myGrey,
          body: CustomScrollView(
            slivers: [
              buildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          characterInfo(
                            title: 'job :',
                            value: character.jobs.join(' / '),
                          ),
                          myDivider(endIndent: 300),
                          characterInfo(
                              title: 'Appeared in :',
                              value: character.categoryForTwoSeries),
                          myDivider(endIndent: 230),
                          character.appearance.isEmpty
                              ? Container()
                              : characterInfo(
                                  title: 'Seasons in :',
                                  value: character.appearance.join(' / ')),
                          character.appearance.isEmpty
                              ? Container()
                              : myDivider(endIndent: 240),
                          characterInfo(
                              title: 'Status :', value: character.status),
                          myDivider(endIndent: 280),
                          character.betterCallSaulAppearance.isEmpty
                              ? Container()
                              : characterInfo(
                                  title: ' Better Call Saul Appearance :',
                                  value: character.betterCallSaulAppearance
                                      .join(' / ')),
                          character.betterCallSaulAppearance.isEmpty
                              ? Container()
                              : myDivider(endIndent: 150),
                          characterInfo(
                            title: ' Actor/Actress :',
                            value: character.name,
                          ),
                          myDivider(endIndent: 210),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<CharactersCubit,CharactersState>(
                            builder: (BuildContext context, state) {
                              return checkIfQuotesAreLoaded(state);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                    )
                  ],
                ),
              ),
            ],
          ),
        );

  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return RandomQuoteOrSpace(state);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget RandomQuoteOrSpace( state) {
    var quotes = state.quotes;

    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 20,
            shadows: [
              Shadow(
                  blurRadius: 7,
                  offset: Offset(0, 0),
                  color: MyColors.myYellow),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myWhite),
        ),
        centerTitle: true,
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo({String title, String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        TextSpan(
          text: value,
          style: TextStyle(color: MyColors.myWhite, fontSize: 16),
        )
      ]),
    );
  }

  Widget myDivider({double endIndent}) {
    return Divider(
      height: 30,
      thickness: 2,
      color: MyColors.myYellow,
      endIndent: endIndent,
    );
  }
}

//
