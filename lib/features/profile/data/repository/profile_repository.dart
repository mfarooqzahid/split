import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:split/core/error/failure.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/features/profile/data/data_sources/profile_local_datasource.dart';
import 'package:split/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:split/features/profile/data/model/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile?>> getUserProfile(String userId);
  Future<Either<Failure, UserProfile>> updateUserProfile({
    required String userId,
    required String userName,
    required String email,
    required String profileUrl,
  });

  Future<Either<Failure, void>> clearLocalProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  const ProfileRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile({
    required String userId,
    required String userName,
    required String email,
    required String profileUrl,
  }) async {
    try {
      final updatedRemoteProfile = await remoteDataSource.updateProfile(
        userId: userId,
        userName: userName,
        email: email,
        profileUrl: profileUrl,
      );

      await localDataSource.cacheProfile(updatedRemoteProfile);

      return right(updatedRemoteProfile);
    } on PostgrestException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      Logger.log("[Profile Respository]: updateUserProfile -> ${e.toString()}");
      return left(const Failure(message: "Could not update profile, an unknown error has occured"));
    }
  }

  @override
  Future<Either<Failure, UserProfile?>> getUserProfile(String userId) async {
    try {
      final UserProfile? localProfile = localDataSource.getCachedProfile();

      if (localProfile != null) {
        return right(localProfile);
      }
      final UserProfile? remoteProfile =
          await remoteDataSource.fetchProfile(userId);
      Logger.log("Local Profile is not null");
      if (remoteProfile != null) {
        localDataSource.cacheProfile(remoteProfile);
        return right(remoteProfile);
      }

      return right(null);
    } on PostgrestException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      Logger.log("[Profile Respository]: getUserProfile -> ${e.toString()}");
      return left(const Failure(message: "Could not update profile, an unknown error has occured"));
    }
  }

  @override
  Future<Either<Failure, void>> clearLocalProfile() async {
    try {
      await localDataSource.clearCachedProfile();
      return right(null);
    } on HiveError catch (e) {
      return left(Failure (message: e.message));
    }
  }
}
