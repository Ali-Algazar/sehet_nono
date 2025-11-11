import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/features/growth/data/repositories/growth_repository.dart';
import 'growth_state.dart';

class GrowthCubit extends Cubit<GrowthState> {
  GrowthCubit(this.growthRepository) : super(GrowthInitial());
  final GrowthRepository growthRepository;

  Future<void> fetchGrowthData(String childId) async {
    emit(GrowthLoading());
    final result = await growthRepository.getGrowthData(childId);
    result.fold(
      (failure) => emit(GrowthError(failure.message)),
      (growthData) => emit(GrowthSuccess(growthData)),
    );
  }

  Future<void> addGrowthData(String childId, growthModel) async {
    emit(GrowthLoading());
    final result = await growthRepository.addGrowthData(childId, growthModel);
    result.fold(
      (failure) => emit(GrowthError(failure.message)),
      (growthData) => emit(GrowthSuccess(growthData)),
    );
  }

  Future<void> updateGrowthData(
    String childId,
    growthModel,
    int recordIndex,
  ) async {
    emit(GrowthLoading());
    final result = await growthRepository.updateGrowthData(
      childId,
      growthModel,
      recordIndex,
    );
    result.fold(
      (failure) => emit(GrowthError(failure.message)),
      (growthData) => emit(GrowthSuccess(growthData)),
    );
  }

  Future<void> deleteGrowthData(
    String childId,
    String growthId,
    int recordIndex,
  ) async {
    emit(GrowthLoading());
    final result = await growthRepository.deleteGrowthData(
      childId,
      growthId,
      recordIndex,
    );
    result.fold(
      (failure) => emit(GrowthError(failure.message)),
      (growthData) => emit(GrowthSuccess(growthData)),
    );
  }
}
