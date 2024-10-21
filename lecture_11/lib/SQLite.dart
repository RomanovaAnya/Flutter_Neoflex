import 'package:flutter/material.dart';
import 'package:path/path.dart' as pathLib;
import 'package:sqflite/sqflite.dart';
import 'dart:math' as math;

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State <App2> {
  late Database db; // Переменная для хранения экземпляра базы данных
  bool isLoading = true; // Индикатор состояния загрузки

  @override
  void initState() {
    super.initState();
    _init(); // Инициализация базы данных при создании виджета
  }

  // Метод для получения пути к базе данных
  Future<String> get getDbPath async => await getDatabasesPath(); // Асинхронное получение пути к базе данных

  // Метод для инициализации базы данных
  Future<void> _init() async {
    var getDatabasesPath = await getDbPath;
    String path = pathLib.join(getDatabasesPath, 'demo.db'); // Составление пути к файлу базы данных

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      },
    );

    showMessage('База данных открыта'); // Отображение сообщения при открытии базы данных

    setState(() {
      isLoading = false; // Обновление состояния загрузки до false
    });
  }

  // Метод для отображения сообщения с помощью Snackbar
  void showMessage(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 1),
    ));
  }

  // Метод для удаления базы данных
  Future<void> deleteDB() async {
    String path = pathLib.join(await getDbPath, 'demo.db');
    await deleteDatabase(path);
  }

  @override
  void dispose() {
    db.close(); // Закрытие базы данных при уничтожении виджета
    super.dispose(); // Необходимо вызвать super.dispose() для правильного завершения состояния
  }

  Future<void> insertIntoDB() async {
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test (name, value, num) VALUES (?, ?, ?)',
          [
            'some name',
            math.Random().nextInt(1000),
            math.Random().nextDouble(),
          ]
      );
      print('Вставлено: $id1');
    });

    setState(() {}); // Перестроить виджет для отображения изменений
  }

  Future<void> updateIntoDB() async {
    await db.rawUpdate(
        'UPDATE Test SET name = ?, value = ? WHERE name = ?',
        ['updated name', '8866', 'some name']
    );
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getDataFromDB() async {
    return await db.rawQuery('SELECT * FROM Test');
  }

  Future<void> clearDB() async {
    await db.rawDelete('DELETE FROM Test');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: insertIntoDB, icon: const Icon(Icons.save)),
            IconButton(onPressed: updateIntoDB, icon: const Icon(Icons.update)),
            IconButton(onPressed: clearDB, icon: const Icon(Icons.delete)),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator.adaptive()) // Отображение индикатора загрузки при выполнении
            : FutureBuilder<List<Map<String, dynamic>>>(
            future: getDataFromDB(), // Получение данных из базы данных
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox(); // Возврат пустого блока, если нет данных
              }

              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('Нет данных')); // Отображение сообщения "Нет данных", если таблица пуста
              }

              return ListView.builder(
                itemCount: snapshot.data!.length, // Количество элементов в снимке
                itemBuilder: (context, index) {
                  final item = snapshot.data![index]; // Получение данных для текущего индекса

                  return Row(
                    children: [
                      Expanded(child: Text(item['id'].toString())),
                      Expanded(child: Text(item['name'].toString())),
                      Expanded(child: Text(item['value'].toString())),
                      Expanded(child: Text(item['num'].toString())),
                    ],
                  );
                },
              );
            }
        )
    );
  }
}
