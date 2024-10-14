import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Romanova App")),
      body: Center( // Центрируем содержимое на экране
        child: ImageTextSwitcher(),
      ),
    ),
  ));
}

class ImageTextSwitcher extends StatefulWidget {
  @override
  _ImageTextSwitcherState createState() => _ImageTextSwitcherState();
}

class _ImageTextSwitcherState extends State<ImageTextSwitcher> {
  int currentIndex = 0;

  final List<String> texts = [
    "Выбери своего агента",
    "Jett",
    "Sky",
  ];

  final List<String> images = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
  ];

  void _nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % texts.length; // Циклический переход
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _nextImage, // Меняем изображение по нажатию
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(images[currentIndex]), // Показываем текущее изображение
          SizedBox(height: 20), // Отступ
          Text(texts[currentIndex], style: TextStyle(fontSize: 22)), // Показываем текст
        ],
      ),
    );
  }
}
