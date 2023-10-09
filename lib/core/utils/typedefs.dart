import 'package:dartz/dartz.dart';
import 'package:repege/core/errors/failure.dart';

typedef ResultStream<T> = Either<Failure, Stream<T>>;

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
