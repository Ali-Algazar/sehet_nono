import 'package:dartz/dartz.dart';

import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sehet_nono/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:sehet_nono/features/auth/data/model/user_model.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDataSource localDataSource;
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data);
        await localDataSource.saveUser(userModel);
        await localDataSource.saveAuthToken(response.data['token']);
        return Right(userModel);
      } else {
        return Left(
          ServerFailure(
            '${response.data['message']} with status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure('Login failed : $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthToken();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Logout failed : $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
  }) async {
    try {
      var response = await remoteDataSource.register(
        email: email,
        password: password,
      );
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data);
        await localDataSource.saveUser(userModel);
        await localDataSource.saveAuthToken(response.data['token']);
        return Right(userModel);
      } else {
        return Left(
          ServerFailure(
            '${response.data['message']} with status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure('Register failed : $e'));
    }
  }
}
