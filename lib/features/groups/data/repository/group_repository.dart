import 'package:dartz/dartz.dart';
import 'package:split/core/error/failure.dart';
import 'package:split/features/groups/data/data_sources/group_remote_datasource.dart';
import 'package:split/features/groups/data/models/group.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class GroupRepository {
  Future<Either<Failure, void>> createGroup({required CreateGroupBody body});
  Future<Either<Failure, Group>> joinGroup({required String groupId});
}

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDatasource groupRemoteDatasource;

  GroupRepositoryImpl({required this.groupRemoteDatasource});
  @override
  Future<Either<Failure, void>> createGroup(
      {required CreateGroupBody body}) async {
    try {
      await groupRemoteDatasource.createGroup(body: body);
      return right(null);
    } on PostgrestException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Group>> joinGroup({required String groupId}) {
    throw UnimplementedError();
  }
}
