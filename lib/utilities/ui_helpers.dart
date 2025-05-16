import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khookbook/utilities/constants.dart';

/// Picks a card color based on whether it's a full category (has description)
/// or a specific-category meal. Pass `hasDescription: true` for the category overview.
Color pickCardColor({String? id, required bool hasDescription}) {
  final List<Color> palette = hasDescription ? kCardColours : Colors.accents;
  if (id != null) {
    // stable based on ID hash
    final idx = id.hashCode.abs() % palette.length;
    return palette[idx];
  }
  // random fallback
  return palette[Random().nextInt(palette.length)];

  // final list = isCategoryList ? kCardColours : Colors.accents;
  // final index = id != null
  //     ? int.tryParse(id)!.abs() % list.length
  //     : Random().nextInt(list.length);
  // return list[index];
}
