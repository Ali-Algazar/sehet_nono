import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_record_model.dart';

abstract class ScheduleLocalDataSource {
  Future<void> cacheScheduleRecordList(
    List<VaccineRecordModel> ListeduleRecordList,
  );
  Future<List<VaccineRecordModel>> getCachedScheduleRecordList();
  Future<void> updataVaccineStatus(
    String scheduleRecordId,
    String status, {
    String? note,
  });
}

class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  @override
  Future<void> cacheScheduleRecordList(
    List<VaccineRecordModel> scheduleRecordList,
  ) async {
    for (var scheduleRecord in scheduleRecordList) {
      await HiveHelper.putData(
        boxName: kVaccineRecordBox,
        key: scheduleRecord.id,
        value: scheduleRecord,
      );
    }
  }

  @override
  Future<List<VaccineRecordModel>> getCachedScheduleRecordList() async {
    List<VaccineRecordModel> scheduleRecordList = [];
    var list = await HiveHelper.getAllValues(kVaccineRecordBox);

    for (var element in list) {
      scheduleRecordList.add(element);
    }

    return scheduleRecordList;
  }

  @override
  Future<void> updataVaccineStatus(
    String scheduleRecordId,
    String status, {
    String? note,
  }) async {
    var schedule =
        await HiveHelper.getData(
              boxName: kVaccineRecordBox,
              key: scheduleRecordId,
            )
            as VaccineRecordModel;

    schedule.status = status;

    if (note != null) {
      schedule.notes = note;
    }
    schedule.save();
  }
}
