
class UserProfile {
  final String id;
  final String email;
  final String name;
  final String profileUrl;
  final DateTime createAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.profileUrl,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'profileUrl': profileUrl,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.name == name &&
      other.profileUrl == profileUrl &&
      other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      profileUrl.hashCode ^
      createAt.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, profileUrl: $profileUrl, createAt: $createAt)';
  }
}
