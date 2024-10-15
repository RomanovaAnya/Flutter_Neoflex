import 'package:flutter/material.dart';

void main() {
  // Объявляем переменные с null safety
  int? nullableInt;
  String nonNullableString = "Hello, world!";

  // Оператор проверки на null (?)
  print(nullableInt?.toString()); // Выведет null, так как nullableInt равен null

  // Оператор присваивания по умолчанию (??)
  String anotherString = nonNullableString ?? "Default value";
  print(anotherString); // Выведет "Hello, world!", так как nonNullableString не равен null

  // Оператор с утверждением типа (!)
  int anotherNullableInt = nullableInt!.toInt(); // Будет ошибка времени выполнения, так как nullableInt равен null

  // Оператор каскадного вызова (..)
  StringBuffer buffer = StringBuffer()
    ..write("Hello, ")
    ..write("world!");

  print(buffer.toString()); // Выведет "Hello, world!"
}
