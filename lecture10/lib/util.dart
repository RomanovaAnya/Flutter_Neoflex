import 'dart:math';
import 'package:flutter/material.dart';

// Утилита для генерации случайных цветом
class Util {
  static Color randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}