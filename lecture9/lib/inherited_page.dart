import 'package:flutter/material.dart';
import 'package:lecture9/until.dart';
import 'app_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); // Создание состояния для виджета
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Верхняя панель
      backgroundColor: Colors.teal,
      title: const Text('Домашняя страница')),
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          color: AppDataProvider.of(context)?.appData.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ // Дочерние виджеты
              Text(AppDataProvider.of(context)?.appData.backgroundColor.toString() ?? ''), // Отображение цвета
              ElevatedButton( // Создание кнопки
                onPressed: () {
                  setState(() {
                    AppDataProvider.of(context)
                        ?.appData
                        .changeBackgroundColor(Util.randomColor()); // Изменение цвета по нажатию
                  });
                },
                child: const Text('Изменить цвет'), // Надпись на кнопке
              ),
              ElevatedButton( // Вторая кнопка
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondPage(), // Переход на вторую страницу
                    ),
                  );
                },
                child: const Text('Перейти на вторую страницу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Second Page
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Верхняя панель
      backgroundColor: Colors.teal, title: const Text('Вторая страница')),
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          color: AppDataProvider.of(context)?.appData.backgroundColor, // Цвет контейнера
          child: Center(
            child: Text(
              'Current color: ${AppDataProvider.of(context)?.appData.backgroundColor.toString() ?? ''}', // Отображение цвета
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}