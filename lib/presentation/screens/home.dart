// @dart=2.9

import 'package:bloc_app/business_logic/cubit/chracters_cubit.dart';
import 'package:bloc_app/business_logic/cubit/chracters_state.dart';
import 'package:bloc_app/constants/my_colors.dart';
import 'package:bloc_app/data/models/characters_model.dart';
import 'package:bloc_app/presentation/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Character> allCharacters;
  List<Character> searchedCharacters;
  bool _isSearching = false;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allCharacters=
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();

  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
          hintText: "Find a character...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addserachedItems(searchedCharacter);
      },
    );
  }

  void addserachedItems(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((element) =>
            element.name.toLowerCase().startsWith(searchedCharacter))
        .toList();

    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            )),
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
   _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

 void _clearSearch(){
    setState(() {
      searchController.clear();
    });
 }







Widget _buildAppBarTitle(){
    return Text('Characters',style: TextStyle(color: MyColors.myGrey),);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      leading: _isSearching?BackButton(color: MyColors.myGrey,):Container(),

        actions: _buildAppBarActions() ,
        backgroundColor: MyColors.myYellow,
        title:_isSearching ? _buildSearchField():_buildAppBarTitle(),
      ),
      body: BlocConsumer<CharactersCubit, CharactersState>(
        listener: (BuildContext context, state) {
          if (state is CharactersLoaded) {
            allCharacters = state.characters;
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ));
          }
        },
        builder: (BuildContext context, state) {
          return ConditionalBuilder(
            condition: allCharacters.isNotEmpty,
            builder: (context) => buildItems(allCharacters: allCharacters,searchedCharacters: searchedCharacters),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: MyColors.myYellow,
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildItems ( {allCharacters,searchedCharacters} )=> SingleChildScrollView(

    child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount:  searchController.text.isEmpty ? allCharacters.length: searchedCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(character: searchController.text.isEmpty ? allCharacters[index]: searchedCharacters[index],);
        }),
  );
}
