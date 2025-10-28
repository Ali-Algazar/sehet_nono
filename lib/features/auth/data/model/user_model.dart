import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String name;

  UserModel({required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }
}
