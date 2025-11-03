import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/features/growth/data/model/growth_model.dart';

abstract class GrowthLocalDataSource {
  Future<List<GrowthModel>> getGrowthDataForChild(String childId);
  Future<void> cacheGrowthDataForChild(
    String childId,
    List<GrowthModel> growthData,
  );
  Future<void> updateGrowthRecord(
    int recordIndex,
    String childId, {
    String? weight,
    String? height,
    String? headCircumference,
    String? dateMeasured,
    String? note,
  });
  Future<void> clearGrowthData(String childId);
  Future<void> deleteGrowthRecord(int recordIndex, String childId);
}

class GrowthLocalDataSourceImpl implements GrowthLocalDataSource {
  @override
  Future<void> cacheGrowthDataForChild(
    String childId,
    List<GrowthModel> growthData,
  ) async {
    await HiveHelper.putData(
      boxName: kGrowthBox,
      key: childId,
      value: growthData,
    );
  }

  @override
  Future<void> clearGrowthData(String childId) async {
    await HiveHelper.deleteData(boxName: kGrowthBox, key: childId);
  }

  @override
  Future<void> deleteGrowthRecord(int recordIndex, String childId) async {
    var growthDataList = await getGrowthDataForChild(childId);

    if (recordIndex < growthDataList.length) {
      growthDataList.removeAt(recordIndex);
      await cacheGrowthDataForChild(childId, growthDataList);
    }
  }

  @override
  Future<List<GrowthModel>> getGrowthDataForChild(String childId) async {
    final data = await HiveHelper.getData(
      boxName: kGrowthBox,
      key: childId,
      defaultValue: [],
    );
    return data;
  }

  @override
  Future<void> updateGrowthRecord(
    int recordIndex,
    String childId, {
    String? weight,
    String? height,
    String? headCircumference,
    String? dateMeasured,
    String? note,
  }) async {
    var list =
        await HiveHelper.getData(
              boxName: kGrowthBox,
              key: childId,
              defaultValue: [],
            )
            as List<GrowthModel>;
    if (recordIndex < list.length) {
      final updatedRecord = list[recordIndex].copyWith(
        weight: weight,
        height: height,
        headCircumference: headCircumference,
        dateMeasured: dateMeasured,
        note: note,
      );
      list[recordIndex] = updatedRecord;

      await cacheGrowthDataForChild(childId, list);
    }
  }
}
