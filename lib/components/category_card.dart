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
    print('ID: $id--Category--$category.\nDescription: $description');
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          // TODO: Define shape as a vertical rounded rectangle
          color: Colors.red,
          elevation: 4,
          // TODO: Generate random for category & random of an array for
          //  specific_category color: Colors.orangeAccent.shade100,
          shadowColor: Colors.black26,
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
              CircleAvatar(
                foregroundImage: NetworkImage(
                  thumbnail!,
                ),
                radius: 180,
                child: Text(
                  // replace with cache image/gif
                  '$category',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
