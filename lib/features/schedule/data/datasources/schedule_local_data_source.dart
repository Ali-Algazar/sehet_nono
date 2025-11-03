import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_record_model.dart';

abstract class ScheduleLocalDataSource {
  Future<void> cacheScheduleRecordList(
    List<VaccineRecordModel> listeduleRecordList,
    String childId,
  );
  Future<List<VaccineRecordModel>> getCachedScheduleRecordList(String childId);
  Future<void> updataVaccineStatus(
    String childId,
    int index, {
    String? status,
    String? note,
    String? dateAdministered,
  });
}

class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  @override
  Future<void> cacheScheduleRecordList(
    List<VaccineRecordModel> scheduleRecordList,
    String childId,
  ) async {
    await HiveHelper.putData(
      boxName: kVaccineRecordBox,
      key: childId,
      value: scheduleRecordList,
    );
  }

  @override
  Future<List<VaccineRecordModel>> getCachedScheduleRecordList(
    String childId,
  ) async {
    var list =
        await HiveHelper.getData(boxName: kVaccineRecordBox, key: childId)
            as List<VaccineRecordModel>;

    return list;
  }

  @override
  Future<void> updataVaccineStatus(
    String childId,
    int index, {
    String? status,
    String? note,
    String? dateAdministered,
  }) async {
    var lidtSchedule =
        await HiveHelper.getData(boxName: kVaccineRecordBox, key: childId)
            as List<VaccineRecordModel>;

    var schedule = lidtSchedule[index];

    if (status != null) {
      schedule.status = status;
    }
    if (dateAdministered != null) {
      schedule.dateAdministered = dateAdministered;
    }

    if (note != null) {
      schedule.notes = note;
    }
    schedule.save();
  }
}
