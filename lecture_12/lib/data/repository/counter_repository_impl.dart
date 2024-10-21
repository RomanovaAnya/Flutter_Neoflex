import 'package:dartz/dartz.dart';
import '../core/error/failure.dart';
import '../datasource/counter_local_datasource.dart';

abstract class CounterRepository {
  Future<Either<Failure, int>> getCounter();
  Future<Either<Failure, int>> setCounter(int newValue);
}

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDatasource _counterLocalDatasource;

  CounterRepositoryImpl(this._counterLocalDatasource);

  @override
  Future<Either<Failure, int>> getCounter() {
    return _counterLocalDatasource.getCounter();
  }

  @override
  Future<Either<Failure, int>> setCounter(int newValue) {
    return _counterLocalDatasource.setCounter(newValue);
  }
}