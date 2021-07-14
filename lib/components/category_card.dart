import 'dart:math';

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? id, category, thumbnail, description, owner;
  final Function()? onPress;
  final Function? onSave;

  const CategoryCard(
      {Key? key,
      this.id,
      this.category,
      this.thumbnail,
      this.description,
      this.owner,
      this.onPress,
      this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int randomColourIndex = 0;

    Random randomChooser = Random();
    Color selectedColour = Colors.white;

    List<Color> specificColours = [
      Color(0xFFB2E2ED),
      Color(0xFFAEC0EC),
      Color(0xFFABE2D1),
      Color(0xffA6E8E8),
      Color(0xff8593FC),
      Color(0xffF38FA3),
      Color(0xff6ED1B8),
      Color(0xff57B4F2),
      Color(0xffE9A84D),
      Color(0xff67320B),
      Color(0xff38497E)
    ];
    if (id == null && description == null) {
      // specific category list
      randomColourIndex = randomChooser.nextInt(11);
      selectedColour = specificColours[randomColourIndex];
    } else {
      // all categories
      randomColourIndex = randomChooser.nextInt(16);
      selectedColour = Colors.accents[randomColourIndex];
      // selectedColour = Colors.orangeAccent.shade100;
    }

    return GestureDetector(
      onTap: onPress,
      child: Material(
        // TODO: Generate random for category & random of an array for specific_category
        color: selectedColour,
        elevation: 4,
        shadowColor: Colors.black26,
        // TODO: Define shape as a vertical rounded rectangle
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(id != null ? '$id. $category' : '$category'),
            Text(
              description != null ? description! : '',
              maxLines: 2,
            ),
            ClipRRect(
              child: Container(
                // TODO: Size appropriately
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(thumbnail!),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
