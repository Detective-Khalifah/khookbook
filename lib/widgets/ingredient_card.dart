import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  final String ingredient, thumbnail;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    // final selectedColour =
    //     pickCardColor(id: id, hasDescription: measure != null);

    return Card(
      color: Colors.black12,
      elevation: 4,
      shadowColor: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image fills the whole card
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              height: 200,
              width: 160,
              imageUrl: thumbnail,
              fit: BoxFit.contain,
            ),
          ),
          // Text at the bottom center with a tinted background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.black12, // Tint background
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Text(
              ingredient,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
