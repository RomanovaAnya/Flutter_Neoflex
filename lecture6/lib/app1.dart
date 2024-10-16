import 'package:flutter/material.dart';
import 'package:lecture6/page.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ), // ThemeData
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text('Домашняя страница'),
        ), // AppBar
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/image_hand.png',
                    width: 400,
                    height: 300,
                  ),
                  Text(
                    'Нажми на кнопку, чтобы открыть первую страницу',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final String? result =
                          await Navigator.of(context).push<String>(
                        MaterialPageRoute(
                          builder: (context) => const Page1(title: 'New title'),
                        ),
                      ); // MaterialPageRoute
                      print(result);
                    },
                    child: const Text('Открыть'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
