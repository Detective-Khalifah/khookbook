import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:khookbook/utilities/ui_helpers.dart";

class CategoryCard extends StatelessWidget {
  final Function()? onPress;
  final VoidCallback? onSave;

  final String? id, category, thumbnail, description, owner;

  const CategoryCard({
    super.key,
    this.id,
    this.category,
    this.thumbnail,
    this.description,
    this.owner,
    this.onPress,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColour = pickCardColor(
      id: id,
      hasDescription: description != null,
    );

    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: selectedColour,
        elevation: 4,
        shadowColor: Colors.black26,
        child: description == null
            ?
              // Specific Category
              Stack(
                children: [
                  // Image fills the whole card
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: thumbnail!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Text at the bottom center with a tinted background
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black54, // Tint background
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        id != null ? "$id. $category" : "$category",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white, // Ensure text is visible
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Optional save icon
                  if (onSave != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: onSave,
                      ),
                    ),
                ],
              )
            :
              // All Categories
              Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: thumbnail!,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      // Image.network(thumbnail!, fit: BoxFit.contain),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black45],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            id != null ? "$id. $category" : "$category",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Optional description
                          Text(
                            description!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Optional save icon
                  if (onSave != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: onSave,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
