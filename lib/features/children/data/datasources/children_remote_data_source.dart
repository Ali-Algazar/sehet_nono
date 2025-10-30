import 'package:dio/dio.dart';
import 'package:sehet_nono/core/network/end_points.dart';
import 'package:sehet_nono/core/services/api_helper.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';

abstract class ChildrenRemoteDataSource {
  Future<Response> getChildren();
  Future<Response> updateChild(ChildModel child);
  Future<Response> addChild(String name, String birthDate, String gender);
  Future<Response> deleteChild(String childId);
}

class ChildrenRemoteDataSourceImpl implements ChildrenRemoteDataSource {
  final ApiHelper apiHelper;
  ChildrenRemoteDataSourceImpl({required this.apiHelper});
  @override
  Future<Response> addChild(
    String name,
    String birthDate,
    String gender,
  ) async {
    var response = await apiHelper.post(
      ApiEndpoints.addChild,
      data: {"name": name, "dateOfBirth": birthDate, "gender": gender},
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Response> deleteChild(String childId) async {
    var response = await apiHelper.delete(
      ApiEndpoints.deleteChild(childId),
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Response> getChildren() async {
    var response = await apiHelper.get(
      ApiEndpoints.getMyChildren,
      requiresAuth: true,
    );

    return response;
  }

  @override
  Future<Response> updateChild(ChildModel child) async {
    var response = await apiHelper.put(
      ApiEndpoints.updateChild(child.id),
      data: child.toJson(),
      requiresAuth: true,
    );
    return response;
  }
}
