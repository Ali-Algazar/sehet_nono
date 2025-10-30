import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/core/services/api_helper.dart';
import 'package:sehet_nono/core/services/get_it_service.dart';
import 'package:sehet_nono/features/children/data/datasources/children_remote_data_source.dart';

class SyncHelper {
  static StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;

  // 🔄 تشغيل المزامنة الأوتوماتيكية عند عودة الإنترنت
  static void startAutoSync() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) async {
      // خُد أول نتيجة من القائمة
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      if (result != ConnectivityResult.none) {
        print('🌐 Internet is back — starting sync...');
        await _syncPendingOperations();
      }
    });
  }

  static void stopAutoSync() {
    _connectivitySubscription?.cancel();
  }

  // 💾 المزامنة الفعلية
  static Future<void> _syncPendingOperations() async {
    final box = Hive.box(kPendingOperationsKey);

    final List pendingOps = box.values.toList();

    for (var opMap in pendingOps) {
      final op = PendingOperationModel.fromMap(
        Map<String, dynamic>.from(opMap),
      );

      try {
        switch (op.type) {
          case 'ADD_CHILD':
            await _syncAddChild(op);
            break;

          // تقدر تضيف هنا أنواع عمليات تانية:
          // case 'UPDATE_CHILD':
          // case 'DELETE_CHILD':
        }

        // ✅ بعد نجاح العملية احذفها من الـ pending box
        await HiveHelper.deleteData(boxName: kPendingOperationsKey, key: op.id);

        print('✅ Synced operation ${op.id}');
      } catch (e) {
        print('❌ Failed to sync ${op.type}: $e');
        // مش هنحذف العملية، هنجربها تاني لما النت يرجع المرة الجاية
      }
    }
  }

  // 📡 عملية رفع الطفل الجديد للسيرفر
  static Future<void> _syncAddChild(PendingOperationModel op) async {
    final remote = ChildrenRemoteDataSourceImpl(apiHelper: getIt<ApiHelper>());
    final data = op.data;

    await remote.addChild(data['name'], data['dateOfBirth'], data['gender']);
  }
}
