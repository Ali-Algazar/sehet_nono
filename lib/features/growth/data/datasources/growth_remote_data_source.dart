import 'package:dio/dio.dart';
import 'package:sehet_nono/core/network/end_points.dart';
import 'package:sehet_nono/core/services/api_helper.dart';

abstract class GrowthRemoteDataSource {
  Future<Response> getGrowthDataForChild(String childId);
  Future<Response> updateGrowthRecord(
    String recordId, {
    String? weight,
    String? height,
    String? headCircumference,
    String? dateMeasured,
    String? note,
  });

  Future<Response> addGrowthRecord(
    String childId, {
    required String weight,
    required String height,
    String? headCircumference,
    required String dateMeasured,
    String? note,
  });
  Future<Response> deleteGrowthRecord(String recordId);
}

class GrowthRemoteDataSourceImpl implements GrowthRemoteDataSource {
  final ApiHelper apiHelper;
  GrowthRemoteDataSourceImpl(this.apiHelper);

  @override
  Future<Response> addGrowthRecord(
    String childId, {
    required String weight,
    required String height,
    String? headCircumference,
    required String dateMeasured,
    String? note,
  }) async {
    final data = {
      'childId': childId,
      'weight': weight,
      'height': height,
      if (headCircumference != null) 'headCircumference': headCircumference,
      'dateMeasured': dateMeasured,
      if (note != null) 'note': note,
    };
    final response = await apiHelper.post(
      ApiEndpoints.addGrowthRecord,
      requiresAuth: true,
      data: data,
    );
    return response;
  }

  @override
  Future<Response> deleteGrowthRecord(String recordId) async {
    final response = await apiHelper.delete(
      ApiEndpoints.deleteGrowthRecord(recordId),
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Response> getGrowthDataForChild(String childId) async {
    final response = await apiHelper.get(
      ApiEndpoints.getChildGrowthRecords(childId),
      requiresAuth: true,
    );
    return response;
  }

  @override
  Future<Response> updateGrowthRecord(
    String recordId, {
    String? weight,
    String? height,
    String? headCircumference,
    String? dateMeasured,
    String? note,
  }) async {
    final data = {
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (headCircumference != null) 'headCircumference': headCircumference,
      if (dateMeasured != null) 'dateMeasured': dateMeasured,
      if (note != null) 'note': note,
    };
    final response = await apiHelper.put(
      ApiEndpoints.updateGrowthRecord(recordId),
      requiresAuth: true,
      data: data,
    );
    return response;
  }
}
