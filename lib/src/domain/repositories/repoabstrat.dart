// abstact repo

import 'package:dartz/dartz.dart';

import '../../core/network/failure.dart';

abstract class Repo {
  Future<Either<Failure, Map<String, dynamic>>> func();
}
