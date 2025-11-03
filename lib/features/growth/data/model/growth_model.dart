import 'package:hive_flutter/hive_flutter.dart';

part 'growth_model.g.dart';

@HiveType(typeId: 4)
class GrowthModel extends HiveObject {
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

  @HiveField(6)
  String? note;

  GrowthModel({
    required this.id,
    required this.childId,
    required this.height,
    required this.weight,
    this.headCircumference,
    required this.dateMeasured,
    this.note,
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
  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'headCircumference': headCircumference,
      'dateMeasured': dateMeasured,
      'note': note,
    };
  }

  @override
  String toString() {
    return 'GrowthModel(id: $id, childId: $childId, height: $height, weight: $weight, headCircumference: $headCircumference, dateMeasured: $dateMeasured)';
  }

  GrowthModel copyWith({
    String? id,
    String? childId,
    String? height,
    String? weight,
    String? headCircumference,
    String? dateMeasured,
    String? note,
  }) {
    return GrowthModel(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      headCircumference: headCircumference ?? this.headCircumference,
      dateMeasured: dateMeasured ?? this.dateMeasured,
      note: note ?? this.note,
    );
  }
}
