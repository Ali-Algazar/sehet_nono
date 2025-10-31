import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/models/pending_operation_model.dart';
import 'package:sehet_nono/features/children/data/datasources/children_local_data_source.dart';
import 'package:sehet_nono/features/children/data/datasources/children_remote_data_source.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';
import 'package:uuid/uuid.dart';

import 'children_repository.dart';

class ChildrenRepositoryImpl implements ChildrenRepository {
  final ChildrenRemoteDataSource remoteDataSource;
  final ChildrenLocalDataSource localDataSource;
  final Connectivity connectivity;
  ChildrenRepositoryImpl(
    this.connectivity, {
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, List<ChildModel>>> deleteChild(
    String childId, {
    isSync = false,
  }) async {
    try {
      if (isSync == false) {
        final results = await connectivity.checkConnectivity();
        final hasConnection =
            results.isNotEmpty && results.first != ConnectivityResult.none;
        if (hasConnection) {
          var response = await remoteDataSource.deleteChild(childId);
          if (response.statusCode == 200) {
            await localDataSource.clearChild(childId);

            List<ChildModel> children =
                await localDataSource.clearChildrenList() as List<ChildModel>;
            return Right(children);
          } else {
            return Left(
              '${response.data['message']} with status code ${response.statusCode}',
            );
          }
        } else {
          await localDataSource.clearChild(childId);
          HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: childId,
            value: PendingOperationModel(
              id: childId,
              type: 'DELETE_CHILD',
              target: 'child',
              data: {},
              createdAt: DateTime.now(),
            ),
          );
          List<ChildModel> children =
              await localDataSource.clearChildrenList() as List<ChildModel>;

          return right(children);
        }
      } else {
        await remoteDataSource.deleteChild(childId);
        List<ChildModel> children =
            await localDataSource.clearChildrenList() as List<ChildModel>;

        return Right(children);
      }
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<ChildModel>>> getChildren() async {
    try {
      final results = await connectivity.checkConnectivity();
      final hasConnection =
          results.isNotEmpty && results.first != ConnectivityResult.none;
      if (hasConnection) {
        var response = await remoteDataSource.getChildren();
        if (response.statusCode == 200) {
          List<ChildModel> children = (response.data as List).map((child) {
            return ChildModel.fromJson(child);
          }).toList();
          await localDataSource.cacheChildrenList(children);

          return right(await localDataSource.getCachedChildrenList());
        } else {
          return left(ServerFailure('error '));
        }
      } else {
        var listChildren = await localDataSource.getCachedChildrenList();
        return right(listChildren);
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, List<ChildModel>>> updateChild(
    ChildModel child, {
    isSync = false,
  }) async {
    try {
      if (isSync == false) {
        final results = await connectivity.checkConnectivity();
        final hasConnection =
            results.isNotEmpty && results.first != ConnectivityResult.none;
        if (hasConnection) {
          final remoteChild = await remoteDataSource.updateChild(child);
          if (remoteChild.statusCode == 200) {
            var child1 = await localDataSource.getCachedChild(child.id);
            child1?.save();
            List<ChildModel> children =
                await localDataSource.clearChildrenList() as List<ChildModel>;

            return Right(children);
          } else {
            return Left(
              '${remoteChild.data['message']} with status code ${remoteChild.statusCode}',
            );
          }
        } else {
          await localDataSource.cacheChild(child);
          HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: child.id,
            value: PendingOperationModel(
              id: child.id,
              type: 'UPDATE_CHILD',
              target: 'child',
              data: child.toJson(),
              createdAt: DateTime.now(),
            ),
          );
          List<ChildModel> children =
              await localDataSource.clearChildrenList() as List<ChildModel>;

          return right(children);
        }
      } else {
        await remoteDataSource.updateChild(child);
        List<ChildModel> children =
            await localDataSource.clearChildrenList() as List<ChildModel>;

        return right(children);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ChildModel>>> addChild(
    String name,
    String birthDate,
    String gender, {
    isSync = false,
  }) async {
    try {
      if (isSync == false) {
        final results = await connectivity.checkConnectivity();
        final hasConnection =
            results.isNotEmpty && results.first != ConnectivityResult.none;
        if (hasConnection) {
          final remoteChild = await remoteDataSource.addChild(
            name,
            birthDate,
            gender,
          );
          await localDataSource.cacheChild(
            ChildModel.fromJson(remoteChild.data),
          );
          List<ChildModel> children =
              await localDataSource.clearChildrenList() as List<ChildModel>;

          return Right(children);
        } else {
          await localDataSource.cacheChild(
            ChildModel(
              id: Uuid().v4(),
              name: name,
              dateOfBirth: DateTime.parse(birthDate),
              gender: gender,
            ),
          );

          var id = Uuid().v6();
          HiveHelper.putData(
            boxName: kPendingOperationsKey,
            key: id,
            value: PendingOperationModel(
              id: id,
              type: 'ADD_CHILD',
              target: 'child',
              data: {'name': name, 'dateOfBirth': birthDate, 'gender': gender},
              createdAt: DateTime.now(),
            ).toMap(),
          );
          List<ChildModel> children =
              await localDataSource.clearChildrenList() as List<ChildModel>;

          return Right(children);
        }
      } else {
        await remoteDataSource.addChild(name, birthDate, gender);
        List<ChildModel> children =
            await localDataSource.clearChildrenList() as List<ChildModel>;

        return right(children);
      }
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
