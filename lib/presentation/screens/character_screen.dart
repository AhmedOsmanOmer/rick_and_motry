import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/character.dart';
import '../../data/web_serviecs/characters_web_services.dart';
import '../widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  CharactersWebServices cc = CharactersWebServices();
  List<Character>? allCharacters;
  bool _isSearching = false;
  List<Character>? searchForCharacter;
  final _searchController = TextEditingController();

  Widget _buildSearchFiled() {
    return TextField(
      controller: _searchController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Find a Character ...",
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchCharacter) {
        addToSearchedItemList(searchCharacter);
      },
    );
  }

  addToSearchedItemList(String searchCharacter) {
    searchForCharacter = allCharacters!
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch;
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearch() {
    if (_searchController.text.isEmpty) {
      Navigator.pop(context);
    } else {
      setState(() {
        _searchController.clear();
      });
    }
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemCount: _searchController.text.isEmpty
          ? allCharacters!.length
          : searchForCharacter!.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchController.text.isEmpty
              ? allCharacters![index]
              : searchForCharacter![index],
        );
      },
    );
  }

  Widget loadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.myYellow,
    ));
  }

  Widget buildBlocWideget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return loadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget _buildAppBartitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget showNoInternetError() {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "No Internet Connection ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Image.asset("assets/images/no_internet.png")
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        leading: _isSearching
            ? BackButton(color: MyColors.myGrey, onPressed: _stopSearching)
            : null,
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchFiled() : _buildAppBartitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWideget();
          } else {
            return showNoInternetError();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
