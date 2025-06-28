class Group {}

class CreateGroupBody {
  final String name;
  final String avatarUrl;
  final String createdBy;

  CreateGroupBody({required this.name, required this.avatarUrl, required this.createdBy});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar_url': avatarUrl,
      'created_by': createdBy,
    };
  }


  @override
  String toString() => 'CreateGroupBody(name: $name, avatarUrl: $avatarUrl, createdBy: $createdBy)';
}