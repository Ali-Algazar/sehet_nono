import 'package:hive_flutter/hive_flutter.dart';
part 'child_model.g.dart';

@HiveType(typeId: 1)
class ChildModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final DateTime dateOfBirth;

  ChildModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }
}
