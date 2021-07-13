import 'package:flutter/material.dart';

class MealPage extends StatefulWidget {
  final String meal;
  static const String id = 'specific_meal';

  const MealPage({Key? key, required this.meal}) : super(key: key);

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.meal),
        ),
        body: Container());
  }
}
