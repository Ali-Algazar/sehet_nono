import 'package:dartz/dartz.dart';
import 'package:sehet_nono/core/errors/failures.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';

abstract class ChildrenRepository {
  Future<Either<String, List<ChildModel>>> addChild(
    String name,
    String birthDate,
    String gender, {
    isSync = false,
  });
  Future<Either<Failure, List<ChildModel>>> getChildren();
  Future<Either<String, List<ChildModel>>> updateChild(
    ChildModel child, {
    isSync = false,
  });
  Future<Either<String, List<ChildModel>>> deleteChild(
    String childId, {
    isSync = false,
  });
}
