import 'package:flutter/material.dart';

Color select_color_from_category(String category) {
  switch (category) {
    case '업무':
      return Colors.red;
    case '공부':
      return Colors.green;
    case '운동':
      return Colors.blue;
  }
  return Colors.black;
}
