import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tasks = ['Помыть посуду', 'Выгулять собаку', 'Сделать покупки'];

  // Метод для добавления новой задачи в список
  void _addToTasks() {
    String task = _controller.text;
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task); // Добавляем новую задачу в список
      });
      _controller.clear();
    }
  }

  // Метод для удаления задачи по индексу
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Создаем интерфейс приложения
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 88, 75),
        title: Center( // Заголовок в центре
          child: Text("Список задач"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                    child: TextField(
                      controller: _controller, // Привязываем контроллер для получения текста
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addToTasks, // Вызов метода добавления задачи
                    child: Text('Добавить задачу'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final task = _tasks[index]; // Получаем задачу по индексу
                  return ListTile(
                    title: Text(task),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(index), // Вызов метода удаления задачи
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: _tasks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
