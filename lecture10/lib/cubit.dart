import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture10/util.dart';

// Cubit для управления состоянием цвета
class ColorCubit extends Cubit<Color> {
  ColorCubit() : super(Colors.green);

  void changeColor() => emit(Util.randomColor());
}