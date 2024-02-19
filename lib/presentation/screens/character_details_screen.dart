// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rick_and_morty_app/constants/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:rick_and_morty_app/data/models/character.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  const DetailsScreen({super.key, required this.character});

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(
            color: Colors.black
          ),
        ),
        background: Hero(
          tag: character.id.toString(),
          child: Container(
            color: MyColors.myGrey,
            child: Image.network(
              character.image.toString(),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value, style: const TextStyle(fontSize: 18))
        ],
      ),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      thickness: 5,
      height: 30,
      color: MyColors.myYellow,
    );
  }

  List getEpisodeNum(List episodeUrlList) {
    List episodeList = [];
    for (int i = 0; i < episodeUrlList.length; i++) {
      RegExp regExp = RegExp(r"\d+$");
      RegExpMatch? match = regExp.firstMatch(episodeUrlList[i].toString());
      episodeList.add(match!.group(0));
    }
    return episodeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _characterInfo("Name: ", character.name!),
                      _buildDivider(320),
                      _characterInfo("Status: ", character.status!),
                      _buildDivider(315),
                      _characterInfo("Species: ", character.species!),
                      _buildDivider(300),
                      _characterInfo("Gender: ", character.gender!),
                      _buildDivider(310),
                      _characterInfo("Eposide: ",
                          getEpisodeNum(character.episode!).join(" / ")),
                      _buildDivider(305),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
                const SizedBox(height: 500)
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
