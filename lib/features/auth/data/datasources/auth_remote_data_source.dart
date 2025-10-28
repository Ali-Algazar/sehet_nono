import 'package:dio/dio.dart';
import 'package:sehet_nono/core/network/end_points.dart';
import 'package:sehet_nono/core/services/api_helper.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login({required String password, required String email});
  Future<Response> register({required String password, required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiHelper apiHelper;
  AuthRemoteDataSourceImpl({required this.apiHelper});
  @override
  Future<Response> login({required String password, required String email}) {
    return apiHelper.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
  }

  @override
  Future<Response> register({required String password, required String email}) {
    return apiHelper.post(
      ApiEndpoints.register,
      data: {'email': email, 'password': password},
    );
  }
}
