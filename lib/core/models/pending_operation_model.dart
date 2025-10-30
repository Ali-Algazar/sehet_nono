import 'package:hive/hive.dart';

part 'pending_operation_model.g.dart';

@HiveType(typeId: 10)
class PendingOperationModel {
  @HiveField(0)
  final String id; // UUID محلي فريد لكل عملية

  @HiveField(1)
  final String type; // نوع العملية (add, update, delete ...)

  @HiveField(2)
  final String target; // اسم الكيان: user, child, note...

  @HiveField(3)
  final Map<String, dynamic> data; // البيانات نفسها

  @HiveField(4)
  final DateTime createdAt; // وقت تنفيذ العملية محليًا

  PendingOperationModel({
    required this.id,
    required this.type,
    required this.target,
    required this.data,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'target': target,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PendingOperationModel.fromMap(Map<String, dynamic> map) {
    return PendingOperationModel(
      id: map['id'],
      type: map['type'],
      target: map['target'],
      data: Map<String, dynamic>.from(map['data']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
