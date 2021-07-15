import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khookbook/utilities/constants.dart';

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

    if (id == null && description == null) {
      // specific category list
      randomColourIndex = randomChooser.nextInt(11);
      selectedColour = kCardColours[randomColourIndex];
    } else {
      // all categories
      randomColourIndex = randomChooser.nextInt(16);
      selectedColour = Colors.accents[randomColourIndex];
      // selectedColour = Colors.orangeAccent.shade100;
    }

    return GestureDetector(
      onTap: onPress,
      child: Material(
        // TODO: Define shape as a vertical rounded rectangle
        borderRadius: BorderRadius.circular(10),
        // TODO: Generate random for category & random of an array for specific_category
        color: selectedColour,
        elevation: 4,
        shadowColor: Colors.black26,
        type: MaterialType.card,
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
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(thumbnail!),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
