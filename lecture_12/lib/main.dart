import 'package:flutter/material.dart';
import 'data/datasource/file_counter_local_datasource.dart';
import 'data/repository/counter_repository_impl.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterWidget(),
    );
  }
}
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late final CounterRepositoryImpl _counterRepository;
  int _counterValue = 0;

  @override
  void initState() {
    super.initState();
    final localDataSource = FileCounterLocalDatasource();
    _counterRepository = CounterRepositoryImpl(localDataSource);
    _retrieveCounter();
  }

  Future<void> _retrieveCounter() async {
    final result = await _counterRepository.getCounter();
    result.fold(
          (failure) {
        print('Ошибка: ${failure.message}');
      },
          (counter) {
        setState(() {
          _counterValue = counter;
        });
      },
    );
  }

  Future<void> _incrementCounter() async {
    final newValue = _counterValue + 1;
    final result = await _counterRepository.setCounter(newValue);
    result.fold(
          (failure) {
        print('Ошибка: ${failure.message}');
      },
          (updatedCounter) {
        setState(() {
          _counterValue = updatedCounter;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Text(
          'Counter value: $_counterValue',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}