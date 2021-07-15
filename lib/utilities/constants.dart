import 'package:flutter/material.dart';

const List<Color> kCardColours = [
  Color(0xFFB2E2ED),
  Color(0xFFAEC0EC),
  Color(0xFFABE2D1),
  Color(0xffA6E8E8),
  Color(0xff8593FC),
  Color(0xffF38FA3),
  Color(0xff6ED1B8),
  Color(0xff57B4F2),
  Color(0xffE9A84D),
  Color(0xff67320B),
  Color(0xff38497E)
];

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(100.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
  ),
);
