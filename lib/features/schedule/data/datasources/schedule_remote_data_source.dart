import 'package:dio/dio.dart';
import 'package:sehet_nono/core/network/end_points.dart';
import 'package:sehet_nono/core/services/api_helper.dart';

abstract class ScheduleRemoteDataSource {
  Future<Response> getVaccineRecordList(String childId);
  Future<Response> updateVaccineRecord(
    String scheduleId, {
    String? status,
    String? dateAdministered,
    String? notes,
  });
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final ApiHelper apiHelper;
  ScheduleRemoteDataSourceImpl({required this.apiHelper});
  @override
  Future<Response> getVaccineRecordList(String childId) async {
    final response = await apiHelper.get(
      ApiEndpoints.getChildSchedule(childId),
      requiresAuth: true,
    );

    return response;
  }

  @override
  Future<Response> updateVaccineRecord(
    String scheduleId, {
    String? status,
    String? dateAdministered,
    String? notes,
  }) async {
    final data = {
      if (status != null) 'status': status,
      if (dateAdministered != null) 'dateAdministered': dateAdministered,
      if (notes != null) 'notes': notes,
    };
    final response = await apiHelper.put(
      ApiEndpoints.updateScheduleItem(scheduleId),
      requiresAuth: true,

      data: data,
    );

    return response;
  }
}
