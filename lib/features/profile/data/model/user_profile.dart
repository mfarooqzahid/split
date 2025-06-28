import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String profileUrl;
  @HiveField(4)
  final DateTime createAt;
  @HiveField(5)
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.profileUrl,
    required this.createAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'profile_url': profileUrl,
      'create_at': createAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileUrl: map['profile_url'] as String,
      createAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  
  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, name: $name, profileUrl: $profileUrl, createAt: $createAt, updatedAt: $updatedAt)';
  }
}
