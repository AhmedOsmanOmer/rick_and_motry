import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, characterDetailsScreen,arguments: character);
        },
        child: GridTile(
          footer: Hero(
            tag: character.id.toString(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
              color: MyColors.myWhite,
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                    filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "assets/images/loading.gif",
                      image: character.image!)
                  : Image.asset("assets/images/internet_error.gif")),
        ),
      ),
    );
  }
}
