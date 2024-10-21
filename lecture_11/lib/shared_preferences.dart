import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Stateful виджет для приложения
class App1 extends StatefulWidget {
  const App1({super.key});

  @override
  State<App1> createState() => _App1State();
}

// Класс состояния для App1
class _App1State extends State<App1> {
  bool isLoading = true; // Индикатор загрузки для отображения прогресса

  late SharedPreferences prefs;

  final TextEditingController _data = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Ключ для формы для управления её состоянием

  @override
  void initState() {
    super.initState();
    _init();
  }

  // Асинхронный метод для инициализации SharedPreferences
  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance(); // Получаем экземпляр SharedPreferences

    setState(() {
      isLoading = false; // Установка индикатора загрузки в false
    });
  }

  // Асинхронный метод для обработки отправки данных формы
  Future<void> onSumbit() async {
    if (_formKey.currentState!.validate()) {
      // Сохранение значения через SharedPreferences
      await prefs.setInt('counter', int.tryParse(_data.text) ?? 0); // Сохранение целого числа
      await prefs.setString('action', _data.text); // Сохранение строки
      setState(() {});
    }
  }

  // Асинхронный метод для удаления сохраненных данных
  Future<void> onDeleteFile() async {
    await prefs.remove('counter'); // Удаление значения 'counter' из SharedPreferences
    setState(() {}); // Обновление состояния виджета
  }

  // Метод для построения пользовательского интерфейса
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
      // Отображение индикатора загрузки если данные еще загружаются
          ? const Center(
        child: CircularProgressIndicator.adaptive(),
      )
          : Form(
        key: _formKey, // Установка ключа формы
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                // Отображение значения 'counter' или сообщение если данных нет
                '${prefs.getInt('counter') ?? 'Нет данных в counter'}',
              ),
              Text(
                prefs.getString('action') ?? 'Нет данных в action',
              ),
              const SizedBox(height: 16.0), // Отступ
              TextFormField(
                controller: _data, // Привязка контроллера к полю ввода
                validator: (value) {
                  // Валидация текста ввода
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите данные';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Данные'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: onSumbit,
                child: const Text('Отправить'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: onDeleteFile,
                child: const Text('Удалить файл'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
