import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/helper_functions/has_connection.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/core/utils/pending_operation_type.dart';
import 'package:sehet_nono/features/growth/data/datasources/growth_local_data_source.dart';
import 'package:sehet_nono/features/growth/data/datasources/growth_remote_data_source.dart';
import 'package:sehet_nono/features/growth/data/model/growth_model.dart';
import 'package:uuid/uuid.dart';
import 'growth_repository.dart';

class GrowthRepositoryImpl implements GrowthRepository {
  final GrowthRemoteDataSource remoteDataSource;
  final GrowthLocalDataSource localDataSource;
  GrowthRepositoryImpl(this.localDataSource, {required this.remoteDataSource});

  @override
  Future<Either<Failure, List<GrowthModel>>> addGrowthData(
    String childId,
    GrowthModel growthModel, {
    bool isSync = false,
  }) async {
    try {
      if (!isSync) {
        final hasInternet = await hasConnection();
        if (hasInternet) {
          final response = await remoteDataSource.addGrowthRecord(
            childId,
            height: growthModel.height,
            weight: growthModel.weight,
            headCircumference: growthModel.headCircumference,
            dateMeasured: growthModel.dateMeasured,
            note: growthModel.note,
          );
          if (response.statusCode == 201) {
            return await fetchAndCache(childId);
          } else {
            return Left(ServerFailure('Failed to add growth record'));
          }
        } else {
          var key = Uuid().v4();
          await HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: key,
            value: PendingOperationModel(
              id: key,
              type: PendingOperationType.addGrowthRecord,
              target: 'growth',
              data: growthModel.toJson(),

              createdAt: DateTime.now(),
            ),
          );
          final growthList = await localDataSource.getGrowthDataForChild(
            childId,
          );
          growthList.add(growthModel);
          await localDataSource.cacheGrowthDataForChild(childId, growthList);
          return Right(growthList);
        }
      } else {
        await remoteDataSource.addGrowthRecord(
          childId,
          height: growthModel.height,
          weight: growthModel.weight,
          headCircumference: growthModel.headCircumference,
          dateMeasured: growthModel.dateMeasured,
          note: growthModel.note,
        );
        return await fetchAndCache(childId);
      }
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GrowthModel>>> deleteGrowthData(
    String childId,
    String growthId,
    int recordIndex, {
    bool? isSync = false,
  }) async {
    try {
      if (!isSync!) {
        final hasInternet = await hasConnection();
        if (hasInternet) {
          final response = await remoteDataSource.deleteGrowthRecord(growthId);
          if (response.statusCode == 200) {
            return await fetchAndCache(childId);
          } else {
            return Left(ServerFailure('Failed to delete growth record'));
          }
        } else {
          await HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: growthId,
            value: PendingOperationModel(
              id: growthId,
              type: PendingOperationType.deleteGrowthRecord,
              target: 'growth',
              data: {
                'recordId': growthId,
                'childId': childId,
                'index': recordIndex,
              },
              createdAt: DateTime.now(),
            ),
          );
          final growthList = await localDataSource.getGrowthDataForChild(
            childId,
          );
          growthList.removeAt(recordIndex);
          await localDataSource.cacheGrowthDataForChild(childId, growthList);
          return Right(growthList);
        }
      } else {
        await remoteDataSource.deleteGrowthRecord(growthId);
        return await fetchAndCache(childId);
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GrowthModel>>> getGrowthData(
    String childId,
  ) async {
    try {
      final hasInternet = await hasConnection();
      if (hasInternet) {
        return await fetchAndCache(childId);
      } else {
        final localData = await localDataSource.getGrowthDataForChild(childId);
        return Right(localData);
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GrowthModel>>> updateGrowthData(
    String childId,
    GrowthModel growthModel,
    int recordIndex, {
    bool isSync = false,
  }) async {
    if (!isSync) {
      final hasInternet = await hasConnection();
      if (hasInternet) {
        final response = await remoteDataSource.updateGrowthRecord(
          growthModel.id,
          weight: growthModel.weight,
          height: growthModel.height,
          headCircumference: growthModel.headCircumference,
          dateMeasured: growthModel.dateMeasured,
          note: growthModel.note,
        );
        if (response.statusCode == 200) {
          return await fetchAndCache(childId);
        } else {
          return Left(ServerFailure('Failed to update growth record'));
        }
      } else {
        await HiveHelper.putData(
          boxName: kPendingOperationsKey,
          key: growthModel.id,
          value: PendingOperationModel(
            id: growthModel.id,
            type: PendingOperationType.updateGrowthRecord,
            target: 'growth',
            data: {
              'recordId': growthModel.id,
              'childId': childId,
              'data': growthModel.toJson(),
              'index': recordIndex,
            },
            createdAt: DateTime.now(),
          ),
        );
        await localDataSource.updateGrowthRecord(
          recordIndex,
          childId,
          weight: growthModel.weight,
          height: growthModel.height,
          headCircumference: growthModel.headCircumference,
          dateMeasured: growthModel.dateMeasured,
          note: growthModel.note,
        );
        final updatedList = await localDataSource.getGrowthDataForChild(
          childId,
        );
        return Right(updatedList);
      }
    } else {
      await remoteDataSource.updateGrowthRecord(
        growthModel.id,
        weight: growthModel.weight,
        height: growthModel.height,
        headCircumference: growthModel.headCircumference,
        dateMeasured: growthModel.dateMeasured,
        note: growthModel.note,
      );
      return await fetchAndCache(childId);
    }
  }

  Future<Either<Failure, List<GrowthModel>>> fetchAndCache(
    String childId,
  ) async {
    final remoteResponse = await remoteDataSource.getGrowthDataForChild(
      childId,
    );

    if (remoteResponse.statusCode == 200) {
      final List<dynamic> data = remoteResponse.data;
      final growthModels = data.map((e) => GrowthModel.fromJson(e)).toList();

      // Cache the data locally
      await localDataSource.cacheGrowthDataForChild(childId, growthModels);

      return Right(growthModels);
    } else {
      return Left(ServerFailure('Failed to fetch growth data from server'));
    }
  }
}
