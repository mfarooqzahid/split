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
      'profileUrl': profileUrl,
      'createAt': createAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      createAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.name == name &&
        other.profileUrl == profileUrl &&
        other.createAt == createAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        profileUrl.hashCode ^
        createAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, name: $name, profileUrl: $profileUrl, createAt: $createAt, updatedAt: $updatedAt)';
  }
}
