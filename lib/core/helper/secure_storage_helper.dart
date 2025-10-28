import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() => _instance;

  final _storage = const FlutterSecureStorage();

  SecureStorageHelper._internal();

  /// 🔐 حفظ قيمة
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// 📖 قراءة قيمة
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// ❌ حذف قيمة واحدة
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// 🧹 حذف كل البيانات المخزنة
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// 🧾 التحقق إذا كان المفتاح موجودًا
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }

  /// 📋 قراءة كل البيانات كماب
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
