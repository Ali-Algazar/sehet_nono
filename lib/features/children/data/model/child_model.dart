import 'package:hive_flutter/hive_flutter.dart';
part 'child_model.g.dart';

@HiveType(typeId: 1)
class ChildModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final DateTime dateOfBirth;
  @HiveField(4)
  final String parentId;

  ChildModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.parentId,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      parentId: json['parent'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }
}
