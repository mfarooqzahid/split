import 'package:split/core/utils/logger.dart';
import 'package:split/features/profile/data/model/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfile?> fetchProfile(String userId);
  Future<UserProfile> updateProfile({
    required String userId,
    required String userName,
    required String email,
    required String profileUrl,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient client;

  const ProfileRemoteDataSourceImpl({required this.client});
  @override
  Future<UserProfile?> fetchProfile(String userId) async {
    try {
      final response =
          await client.from('users').select().eq('id', userId).maybeSingle();
      if (response == null) {
        Logger.log('[ProfileRemoteDataSource] Profile not found on Supabase.');
        return null;
      }
      final profile = UserProfile.fromMap(response);
      Logger.log(
          '[ProfileRemoteDataSource] Profile fetched from Supabase: $profile');
      return profile;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfile> updateProfile({
    required String userId,
    required String userName,
    required String email,
    required String profileUrl,
  }) async {
    try {
      final Map<String, dynamic> updateData = {
        'id': userId,
        'name': userName,
        'email': email,
        'profileUrl': profileUrl,
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // Try to update existing profile
      final response = await client
          .from('users')
          .upsert(updateData)
          .eq('id', userId)
          .select()
          .single();

      final updatedProfile = UserProfile.fromMap(response);
      Logger.log(
          '[ProfileRemoteDataSource] Profile updated on Supabase: $updatedProfile');
      return updatedProfile;
    } catch (e) {
      Logger.log('[ProfileRemoteDataSource] Error updating profile: $e');
      rethrow;
    }
  }
}
