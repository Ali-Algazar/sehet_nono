import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/features/growth/data/model/growth_model.dart';

abstract class GrowthRepository {
  Future<Either<Failure, List<GrowthModel>>> getGrowthData(String childId);
  Future<Either<Failure, List<GrowthModel>>> addGrowthData(
    String childId,
    GrowthModel growthModel, {
    bool isSync = false,
  });
  Future<Either<Failure, List<GrowthModel>>> updateGrowthData(
    String childId,
    GrowthModel growthModel, {
    bool isSync = false,
  });
  Future<Either<Failure, List<GrowthModel>>> deleteGrowthData(
    String childId,
    String growthId, {
    bool isSync = false,
  });
}
