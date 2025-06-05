import 'package:dartz/dartz.dart';
import 'package:split/core/error/failure.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/features/profile/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient client;

  const ProfileRepository({required this.client});

  Future<Either<Failure, UserProfile?>> fetchUserProfile(String userId) async {
    try {
      final response =
          await client.from('users').select().eq('id', userId).maybeSingle();

      if (response == null) {
        return right(null);
      }

      final profile = UserProfile.fromMap(response);
      Logger.log('[ProfileRepository] User profile fetched: $profile');

      return right(profile);
    } on PostgrestException catch (e) {
      Logger.log('[ProfileRepository] PostgrestException: ${e.message}');
      return left(ServerFailure(e.message));
    } catch (e) {
      Logger.log('[ProfileRepository] Unknown error occurred: $e');
      return left(const UnknownFailure('An unexpected error occurred.'));
    }
  }
}
