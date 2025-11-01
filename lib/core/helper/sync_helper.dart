import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/core/services/get_it_service.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';
import 'package:sehet_nono/features/children/data/repositories/children_repository.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_local_data_source.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:sehet_nono/features/schedule/data/repositories/schedule_repository.dart';
import 'package:sehet_nono/features/schedule/data/repositories/schedule_repository_impl.dart';

class SyncHelper {
  static StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;

  final ChildrenRepository _childrenRepository;

  SyncHelper(this._childrenRepository);

  // 🔄 تشغيل المزامنة الأوتوماتيكية عند عودة الإنترنت
  void startAutoSync() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) async {
      // خُد أول نتيجة من القائمة
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      if (result != ConnectivityResult.none) {
        print('🌐 Internet is back — starting sync...');
        await syncPendingOperations();
      }
    });
  }

  void stopAutoSync() {
    _connectivitySubscription?.cancel();
  }

  // 💾 المزامنة الفعلية
  Future<void> syncPendingOperations() async {
    final List pendingOps = await HiveHelper.getAllValues(
      kPendingOperationsKey,
    );

    if (pendingOps.isEmpty) {
      print('ℹ️ No pending operations to sync.');
      return;
    }

    for (PendingOperationModel op in pendingOps) {
      try {
        switch (op.type) {
          case 'ADD_CHILD':
            await _syncAddChild(op);
            break;
          case 'DELETE_CHILD':
            await syncDeleteChild(op.id);
            break;
          case 'UPDATE_CHILD':
            await syncUpdateChild(ChildModel.fromJson(op.data));
            break;
          case 'UPDATE_VACCINE_RECORD':
            await syncUpdateVaccineRecord(op.data);
            break;

          // تقدر تضيف هنا أنواع عمليات تانية:
          // case 'UPDATE_CHILD':
          // case 'DELETE_CHILD':
        }
        op.delete();

        print('✅ Synced operation ${op.id}');
      } catch (e) {
        print('❌ Failed to sync ${op.type}: $e');
        // مش هنحذف العملية، هنجربها تاني لما النت يرجع المرة الجاية
      }
    }
  }

  Future<void> syncUpdateVaccineRecord(Map<String, dynamic> data) async {
    var scheduleRepository = ScheduleRepositoryImpl(
      localDataSource: getIt<ScheduleLocalDataSource>(),
      remoteDataSource: getIt<ScheduleRemoteDataSource>(),
    );

    await scheduleRepository.updateVaccineRecord(
      data['scheduleId'],
      data['childId'],
      data['index'],
      isSynced: true,
      dateAdministered: data['dateAdministered'],
      notes: data['notes'],
      status: data['status'],
    );
  }

  // 📡 عملية رفع الطفل الجديد للسيرفر
  Future<void> _syncAddChild(PendingOperationModel op) async {
    final data = op.data;

    await _childrenRepository.addChild(
      data['name'],
      data['dateOfBirth'],
      data['gender'],
      isSync: true,
    );
  }

  Future<void> syncUpdateChild(ChildModel child) async {
    await _childrenRepository.updateChild(child, isSync: true);
  }

  Future<void> syncDeleteChild(String childId) async {
    await _childrenRepository.deleteChild(childId, isSync: true);
  }
}
