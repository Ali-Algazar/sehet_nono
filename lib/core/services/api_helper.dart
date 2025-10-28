import 'package:dio/dio.dart';
import '../helper/shared_preferences_service.dart'; // (تم التعديل)

class ApiHelper {
  Dio dio;
  final String baseUrl = 'https://api.example.com/v1/'; // (تم التعديل)

  ApiHelper(this.dio);

  Future<String?> _getAuthToken() async {
    // (تم التعديل) استخدام الـ Service الذي أنشأناه
    return await SharedPreferencesService.getData(key: 'auth_token');
  }

  Future<Options?> _createAuthOptions(bool requiresAuth) async {
    if (requiresAuth) {
      String? token = await _getAuthToken();
      if (token != null) {
        return Options(headers: {'Authorization': 'Bearer $token'});
      }
    }
    return null; // لا يوجد توكن أو غير مطلوب
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? data,
    bool requiresAuth = false,
  }) async {
    Options? options = await _createAuthOptions(requiresAuth);
    // (تم الإصلاح) طلبات GET تستخدم queryParameters
    return await dio.get('$baseUrl$endpoint', queryParameters: data, options: options);
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
