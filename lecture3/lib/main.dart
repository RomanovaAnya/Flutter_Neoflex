import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: MyHomePage(), // Задает домашнюю страницу приложения
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();// Возвращает состояние главной страницы
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    // Инициализация списка плиток с уникальными ключами
    tiles = [
      StatefullColorTile(
        key: UniqueKey(),
      ),
      StatefullColorTile(
        key: UniqueKey(),
      )
    ];
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tiles,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: swapTiles,// Обработчик нажатия на кнопку
          child: const Icon(Icons.switch_access_shortcut)),
    );
  }
  void swapTiles(){
    setState(() {
      tiles.insert(1, tiles.removeAt(0)); // Перемещает первую плитку на вторую позицию
    });
  }
}
class StatefullColorTile extends StatefulWidget{
  const StatefullColorTile({super.key});

  @override
  State<StatefullColorTile> createState() => _StatefullColorfulTileState();
}

class _StatefullColorfulTileState extends State <StatefullColorTile>{
  late Color color; // Переменная для хранения цвета

  @override
  void initState() {
    super.initState();
    // Генерирует случайный цвет из доступных
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Возвращает контейнер с заданным цветом
    return Container(width: 100, height: 100, color: color);
  }
}