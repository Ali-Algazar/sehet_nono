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
  Future<Either<String, void>> deleteChild(String childId) {
    // TODO: implement deleteChild
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ChildModel>>> getChildren() {
    // TODO: implement getChildren
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> updateChild(ChildModel child) {
    // TODO: implement updateChild
    throw UnimplementedError();
  }

  Future<Either<String, void>> addChild(
    String name,
    String birthDate,
    String gender, {
    isSync = false,
  }) async {
    if (isSync == false) {
      final results = await connectivity.checkConnectivity();
      final hasConnection =
          results.isNotEmpty && results.first != ConnectivityResult.none;
      if (hasConnection) {
        try {
          final remoteChild = await remoteDataSource.addChild(
            name,
            birthDate,
            gender,
          );
          await localDataSource.cacheChild(
            ChildModel.fromJson(remoteChild.data),
          );
          return Right(null);
        } catch (e) {
          return Left('Failed to add child remotely: $e');
        }
      } else {
        try {
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
          return Right(null);
        } on Exception catch (e) {
          // TOD
          return Left('Failed to add child locally: $e');
        }
      }
    } else {
      // عملية المزامنة
      try {
        final remoteChild = await remoteDataSource.addChild(
          name,
          birthDate,
          gender,
        );
        return right(null);
      } catch (e) {
        return left('Failed to sync added child: $e');
      }
    }
  }
}
