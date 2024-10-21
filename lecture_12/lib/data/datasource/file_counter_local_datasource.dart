import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import '../core/error/failure.dart';
import 'counter_local_datasource.dart';

class FileCounterLocalDatasource implements CounterLocalDatasource {
  @override
  Future<Either<Failure, int>> getCounter() async {
    try {
      final counter = await readData();

      return Right(counter);
    } catch (e) {
      return Left(Failure(code: 1, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> setCounter(int newValue) async {
    try {
      await writeData(newValue);

      final counter = await readData();

      return Right(counter);
    } catch (e) {
      return Left(Failure(code: 1, message: e.toString()));
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<void> writeData(int data) async {
    final file = await _localFile;

    // Write the file
    await file.writeAsString(data.toString());
  }

  Future<int> readData() async {
    final file = await _localFile;

    if (!file.existsSync()) {
      file.writeAsStringSync('0');
    }

    // Read the file
    final contents = int.tryParse(await file.readAsString());

    return contents ?? 0;
  }
}