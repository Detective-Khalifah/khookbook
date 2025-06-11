import "package:flutter/material.dart";

class EmptyPot extends StatelessWidget {
  const EmptyPot({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: FadeInImage.assetNetwork(
              fit: BoxFit.contain,
              placeholder: "assets/images/cooking_pot.gif",
              // Before image load
              image:
                  "https://media1.tenor.com/images/8a1df0caea44830aa0ecf99ac223c747/tenor.gif?itemid=15085886",
              // After image load
              height: 200,
              width: 300,
            ),
          ),
          Text(
            "Pot is empty!",
            style: TextStyle(
              color: Colors.brown.shade900,
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
