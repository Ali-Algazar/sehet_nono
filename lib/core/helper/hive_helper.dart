import 'package:hive_flutter/hive_flutter.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/features/auth/data/model/user_model.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ChildModelAdapter());
    Hive.registerAdapter(PendingOperationModelAdapter());
  }

  static Future<Box> openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    } else {
      return await Hive.openBox(boxName);
    }
  }

  static Future<void> putData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  static Future<dynamic> getData({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox(boxName);
    return box.get(key);
  }

  static Future<void> deleteData({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  static Future<bool> containsKey({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox(boxName);
    return box.containsKey(key);
  }

  static Future<List> getAllValues(String boxName) async {
    final box = await openBox(boxName);
    return box.values.toList();
  }
}
