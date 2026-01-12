import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? provider;
  @HiveField(4)
  final String? photoUrl;
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.provider,
  });
  factory UserModel.fromJson(jsonData) {
    return UserModel(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      provider: jsonData['provider'],
      photoUrl: jsonData['photoUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'provider': provider,
      'photoUrl': photoUrl,
    };
  }

  UserModel copyWith({String? newName, String? newEmail, String? newPhotoUrl}) {
    return UserModel(
      id: id,
      name: newName ?? name,
      email: newEmail ?? email,
      photoUrl: newPhotoUrl ?? photoUrl,
      provider: provider,
    );
  }
}
