import 'package:dio/dio.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';

class ApiHelper {
  Dio dio;
  SecureStorageHelper storageHelper;
  final String baseUrl = 'https://mom-hf4l.vercel.app/api/v1/';

  ApiHelper({required this.dio, required this.storageHelper});

  Future<String?> _getAuthToken() async {
    return await storageHelper.read(key: kAuthTokenKey);
  }

  Future<Options?> _createAuthOptions(bool requiresAuth) async {
    if (requiresAuth) {
      String? token = await _getAuthToken();
      if (token != null) {
        return Options(headers: {'Authorization': 'Bearer $token'});
      }
    }
    return null;
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? data,
    bool requiresAuth = false,
  }) async {
    Options? options = await _createAuthOptions(requiresAuth);

    return await dio.get(
      '$baseUrl$endpoint',
      queryParameters: data,
      options: options,
    );
  }

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
    bool requiresAuth = false,
  }) async {
    Options? options = await _createAuthOptions(requiresAuth);
    return await dio.post('$baseUrl$endpoint', data: data, options: options);
  }

  Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
    bool requiresAuth = false,
  }) async {
    Options? options = await _createAuthOptions(requiresAuth);
    return await dio.put('$baseUrl$endpoint', data: data, options: options);
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? data,
    bool requiresAuth = false,
  }) async {
    Options? options = await _createAuthOptions(requiresAuth);
    return await dio.delete('$baseUrl$endpoint', data: data, options: options);
  }
}
