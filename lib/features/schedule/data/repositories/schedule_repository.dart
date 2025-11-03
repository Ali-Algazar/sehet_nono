import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_record_model.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<VaccineRecordModel>>> getVaccineRecordList(
    String childId,
  );
  Future<Either<Failure, List<VaccineRecordModel>>> updateVaccineRecord(
    String scheduleId,
    String childId,
    int index, {
    String? status,
    String? dateAdministered,
    String? notes,
    bool isSynced = false,
  });
}
