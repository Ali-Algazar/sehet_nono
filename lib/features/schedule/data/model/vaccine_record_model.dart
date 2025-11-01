import 'package:hive_flutter/hive_flutter.dart';
import 'package:sehet_nono/features/schedule/data/model/vaccine_model.dart';

part 'vaccine_record_model.g.dart';

@HiveType(typeId: 3)
class VaccineRecordModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String childId;
  @HiveField(2)
  final VaccineModel vaccine;
  @HiveField(3)
  final DateTime dueDate;
  @HiveField(4)
  String status;
  @HiveField(5)
  String? notes;

  VaccineRecordModel({
    required this.id,
    required this.childId,
    required this.vaccine,
    required this.dueDate,
    required this.status,
    this.notes,
  });

  factory VaccineRecordModel.fromJson(Map<String, dynamic> json) {
    return VaccineRecordModel(
      id: json['_id'],
      childId: json['child'],
      vaccine: VaccineModel.fromJson(json['vaccine']),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,

      'child': childId,
      'vaccine': vaccine.toJson(),
      'dueDate': dueDate.toIso8601String(),
      'status': status,

      'notes': notes,
    };
  }
}
