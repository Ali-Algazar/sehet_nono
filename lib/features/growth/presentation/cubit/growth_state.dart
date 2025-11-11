import 'package:sehet_nono/features/growth/data/model/growth_model.dart';

abstract class GrowthState {}

class GrowthInitial extends GrowthState {}

class GrowthLoading extends GrowthState {}

class GrowthSuccess extends GrowthState {
  final List<GrowthModel> growthData;

  GrowthSuccess(this.growthData);
}

class GrowthError extends GrowthState {
  final String message;
  GrowthError(this.message);
}
