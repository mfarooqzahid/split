import 'package:split/core/utils/logger.dart';
import 'package:split/features/groups/data/models/group.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class GroupRemoteDatasource {
  Future<void> createGroup({required CreateGroupBody body});
  Future<Group> joinGroup({required String groupId});
}

class GroupRemoteDatasourceImpl implements GroupRemoteDatasource {
  final SupabaseClient client;

  const GroupRemoteDatasourceImpl({required this.client});
  @override
  Future<void> createGroup({required CreateGroupBody body}) async {
    try {
      final response = await client.from('groups').insert(body.toMap());
      Logger.log('Group created with response: $response');
      return;
    } catch (e) {
      Logger.log('Error creating group: $e');
      rethrow;
    }
  }

  @override
  Future<Group> joinGroup({required String groupId}) {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }
}
