import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/features/auth/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> clearAuthToken();
  Future<void> saveUser(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageHelper storageHelper;
  AuthLocalDataSourceImpl({required this.storageHelper});

  get kUserKey => null;
  @override
  Future<void> clearAuthToken() {
    return storageHelper.delete(key: kAuthTokenKey);
  }

  @override
  Future<String?> getAuthToken() {
    return storageHelper.read(key: kAuthTokenKey);
  }

  @override
  Future<void> saveAuthToken(String token) {
    return storageHelper.write(key: kAuthTokenKey, value: token);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await HiveHelper.putData(boxName: userBox, key: userKey, value: user);
  }
}
