import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_record_model.dart';
import 'package:sehet_nono/features/schedule/data/repositories/schedule_repository.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends Cubit<VaccinationState> {
  VaccinationCubit(this._scheduleRepository) : super(VaccinationInitial());
  final ScheduleRepository _scheduleRepository;
  Future<void> fetchVaccineRecords(String childId) async {
    emit(VaccinationLoading());
    final records = await _scheduleRepository.getVaccineRecordList(childId);
    records.fold(
      (l) => emit(VaccinationError(message: l.message)),
      (r) => emit(VaccinationLoaded(vaccineRecords: r)),
    );
  }

  Future<void> updateVaccineRecord(
    String scheduleId,
    String childId,
    int index, {
    String? status,
    String? dateAdministered,
    String? notes,
  }) async {
    emit(VaccinationLoading());
    final result = await _scheduleRepository.updateVaccineRecord(
      scheduleId,
      childId,
      index,
      status: status,
      dateAdministered: dateAdministered,
      notes: notes,
    );
    result.fold((l) => emit(VaccinationError(message: l.message)), (r) {
      // After updating, refetch the vaccine records to get the latest data
      emit(VaccinationLoaded(vaccineRecords: r));
    });
  }
}
