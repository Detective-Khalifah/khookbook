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
          Image.asset(
            "assets/images/cooking_pot.gif",
            fit: BoxFit.contain,
            height: 200,
            width: 300,
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
