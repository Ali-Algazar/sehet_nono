import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/services/hive_helper.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';

abstract class ChildrenLocalDataSource {
  Future<void> cacheChildrenList(List<ChildModel> children);
  Future<List<ChildModel>> getCachedChildrenList();
  Future<void> clearChildrenList();
  Future<void> cacheChild(ChildModel child);
  Future<ChildModel?> getCachedChild(String id);
  Future<void> clearChild(String id);
}

class ChildrenLocalDataSourceImpl implements ChildrenLocalDataSource {
  @override
  Future<void> cacheChild(ChildModel child) async {
    await HiveHelper.putData(
      boxName: kChildrenBox,
      key: child.id,
      value: child,
    );
  }

  @override
  Future<void> cacheChildrenList(List<ChildModel> children) async {
    for (var child in children) {
      HiveHelper.putData(boxName: kChildrenBox, key: child.id, value: child);
    }
  }

  @override
  Future<void> clearChild(String id) async {
    HiveHelper.deleteData(boxName: kChildrenBox, key: id);
  }

  @override
  Future<void> clearChildrenList() async {
    HiveHelper.clearBox(kChildrenBox);
  }

  @override
  Future<ChildModel?> getCachedChild(String id) async {
    return await HiveHelper.getData(boxName: kChildrenBox, key: id);
  }

  @override
  Future<List<ChildModel>> getCachedChildrenList() async {
    return await HiveHelper.getAllValues(kChildrenBox) as List<ChildModel>;
  }
}
