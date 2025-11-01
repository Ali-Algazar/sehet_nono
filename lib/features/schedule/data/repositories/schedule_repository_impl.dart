import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/helper_functions/has_connection.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_local_data_source.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_record_model.dart';
import 'schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleLocalDataSource localDataSource;
  ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<VaccineRecordModel>>> getVaccineRecordList(
    String childId,
  ) async {
    try {
      final hasInternat = await hasConnection();
      if (hasInternat) {
        // لو هناك اتصال
        return await fetchAndCacheVaccineRecords(childId);
      } else {
        final list = await localDataSource.getCachedScheduleRecordList(childId);

        return right(list);
      }
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VaccineRecordModel>>> updateVaccineRecord(
    String scheduleId,
    String childId,
    int index, {
    String? status,
    String? dateAdministered,
    String? notes,
    bool isSynced = false,
  }) async {
    try {
      if (isSynced == false) // لو مش عملية مزامنه
      {
        // بشوف لو في نت
        final hasInternat = await hasConnection();
        if (hasInternat) //لو في نت
        {
          // ابعت طلب التحديث للسيرفر
          await remoteDataSource.updateVaccineRecord(
            scheduleId,
            dateAdministered: dateAdministered,
            notes: notes,
            status: status,
          );
          // ببعت طلب لي السيرفر عشان اجيب الجدول تاني بعد التحديث
          return await fetchAndCacheVaccineRecords(childId);
        } else // لو مفيش نت
        {
          await localDataSource.updataVaccineStatus(
            childId,
            index,
            dateAdministered: dateAdministered,
            note: notes,
            status: status,
          );

          HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: scheduleId,
            value: PendingOperationModel(
              id: scheduleId,
              type: 'UPDATE_VACCINE_RECORD',
              target: 'vaccine',
              data: {
                'childId': childId,
                'scheduleId': scheduleId,
                'index': index,
                'dateAdministered': dateAdministered,
                'notes': notes,
                'status': status,
              },
              createdAt: DateTime.now(),
            ),
          );
          // هجيب بيانتات من الكاش علي طول
          List<VaccineRecordModel> list = await localDataSource
              .getCachedScheduleRecordList(childId);

          return right(list);
        }
      }
      // لو هي عملية مزامنه
      else {
        // ابعت طلب التحديث للسيرفر
        await remoteDataSource.updateVaccineRecord(
          scheduleId,
          dateAdministered: dateAdministered,
          notes: notes,
          status: status,
        );
        // بعد لانتنهاء من الطلب التحديث هات البيانات تاني من التخزين لامحلي عشان نتبعتها للكيوبت
        final list = await localDataSource.getCachedScheduleRecordList(childId);
        return right(list);
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<VaccineRecordModel>>> fetchAndCacheVaccineRecords(
    String childId,
  ) async {
    final response = await remoteDataSource.getVaccineRecordList(childId);

    // لو الرسالة صحيحة
    if (response.statusCode == 200) {
      List<VaccineRecordModel> vaccineRecordList = (response.data as List).map((
        vaccineRecord,
      ) {
        return VaccineRecordModel.fromJson(vaccineRecord);
      }).toList();

      await localDataSource.cacheScheduleRecordList(
        vaccineRecordList,
        childId,
      ); // حفظ البيانات

      final List<VaccineRecordModel> list = await localDataSource
          .getCachedScheduleRecordList(childId);

      return right(list);
    }
    return left(ServerFailure('Error fetching vaccine records'));
  }
}
