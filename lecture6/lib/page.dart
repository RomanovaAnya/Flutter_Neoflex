import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Первая страница'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/image_cat.jfif',
              width: 400,
              height: 300,
            ),
            Text(
              'Нажми на кнопку, чтобы вернуться на домашнюю страницу',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
