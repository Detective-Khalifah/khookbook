import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> categoryCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: categoryCards,
        padding: EdgeInsets.all(10),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<dynamic> fetchCategories() async {
    http.Response cats = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    if (cats.statusCode == 200) {
      parseCategories(jsonDecode(cats.body));
    } else
      print('statuscode:: ${cats.statusCode}');
    // if (cats.statusCode == 200) print(cats.body);
  }

  void parseCategories(var recipeCategories) {
    for (int i = 0; i < recipeCategories['categories'].length; i++) {
      String id = recipeCategories['categories'][i]['idCategory'];
      String category = recipeCategories['categories'][i]['strCategory'];
      String thumbnail = recipeCategories['categories'][i]['strCategoryThumb'];
      String description =
          recipeCategories['categories'][i]['strCategoryDescription'];

      print('$id -- $category '); //($thumbnail): $description');

      setState(() {
        categoryCards.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
            elevation: 5,
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(category),
                Image.network('$thumbnail'),
                Text(description),
              ],
            ),
          ),
        ));
      });
    }
  }
}
