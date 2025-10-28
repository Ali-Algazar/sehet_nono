import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/features/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
  });
}
