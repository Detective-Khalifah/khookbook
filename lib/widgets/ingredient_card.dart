import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  final String ingredient, thumbnail, measure;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.thumbnail,
    required this.measure,
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
              child: Column(
                children: [
                  Text(
                    ingredient,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (measure.isNotEmpty)
                    Text(
                      measure,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        )
        //     Stack(
        //   children: [
        //     Positioned.fill(
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(12),
        //         child: CachedNetworkImage(
        //           imageUrl: thumbnail!,
        //           fit: BoxFit.contain,
        //           placeholder: (context, url) => Center(
        //             child: SizedBox(
        //               width: 24,
        //               height: 24,
        //               child: CircularProgressIndicator(strokeWidth: 2),
        //             ),
        //           ),
        //           errorWidget: (context, url, error) => Center(
        //             child: Icon(Icons.broken_image, color: Colors.grey),
        //           ),
        //         ),
        //         // Image.network(thumbnail!, fit: BoxFit.contain),
        //       ),
        //     ),
        //     // Gradient overlay
        //     Positioned.fill(
        //       child: DecoratedBox(
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [Colors.transparent, Colors.black45],
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 8),
        //     Positioned(
        //       bottom: 8,
        //       left: 8,
        //       right: 8,
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 4, bottom: 2),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           crossAxisAlignment: CrossAxisAlignment.stretch,
        //           children: [
        //             Text(
        //               id != null ? '$id. $ingredient' : '$ingredient',
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             // Optional description
        //             Text(
        //               description!,
        //               maxLines: 3,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
