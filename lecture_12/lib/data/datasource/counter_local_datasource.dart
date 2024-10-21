import 'package:dartz/dartz.dart';
import '../core/error/failure.dart';

abstract class CounterLocalDatasource {
  Future<Either<Failure, int>> getCounter();
  Future<Either<Failure, int>> setCounter(int newValue);
}