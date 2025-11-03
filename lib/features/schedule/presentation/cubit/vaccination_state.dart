part of 'vaccination_cubit.dart';

@immutable
sealed class VaccinationState {}

final class VaccinationInitial extends VaccinationState {}

final class VaccinationLoading extends VaccinationState {}

final class VaccinationLoaded extends VaccinationState {
  final List<VaccineRecordModel> vaccineRecords;
  VaccinationLoaded({required this.vaccineRecords});
}

final class VaccinationError extends VaccinationState {
  final String message;
  VaccinationError({required this.message});
}
