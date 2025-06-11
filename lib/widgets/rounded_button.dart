import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final String label;
  final Function() onPressed;

  const RoundedButton({
    super.key,
    required this.colour,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          minimumSize: Size(200, 42),
          // padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: Color(0xFFFFE5C6))),
      ),
    );
  }
}
