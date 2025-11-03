import 'package:hive_flutter/hive_flutter.dart';

part 'growth_model.g.dart';

@HiveType(typeId: 4)
class GrowthModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String childId;
  @HiveField(2)
  final String height;
  @HiveField(3)
  final String weight;
  @HiveField(4)
  final String? headCircumference;
  @HiveField(5)
  final String dateMeasured;

  GrowthModel({
    required this.id,
    required this.childId,
    required this.height,
    required this.weight,
    this.headCircumference,
    required this.dateMeasured,
  });
  factory GrowthModel.fromJson(Map<String, dynamic> json) {
    return GrowthModel(
      id: json['id'] as String,
      childId: json['childId'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      headCircumference: json['headCircumference'] as String?,
      dateMeasured: json['dateMeasured'] as String,
    );
  }
}
