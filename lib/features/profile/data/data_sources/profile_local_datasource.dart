import 'package:hive_flutter/hive_flutter.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/features/profile/data/model/user_profile.dart';

abstract class ProfileLocalDataSource {
  Future<void> init(); // To open the Hive box
  UserProfile? getCachedProfile();
  Future<void> cacheProfile(UserProfile profile);
  Future<void> clearCachedProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  late Box<UserProfile> _userProfileBox;
  static const String _userProfileBoxName = 'userProfileBox';
  static const String _currentUserProfileKey = 'currentUserProfile';

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(_userProfileBoxName)) {
      _userProfileBox = await Hive.openBox<UserProfile>(_userProfileBoxName);
    } else {
      _userProfileBox = Hive.box(_userProfileBoxName);
    }
    Logger.log(
        '[ProfileLocalDataSource] Hive Box initialized: $_userProfileBoxName');
  }

  @override
  UserProfile? getCachedProfile() {
    try {
      final profile = _userProfileBox.get(_currentUserProfileKey);
      Logger.log(
          '[ProfileLocalDataSource] Fetched profile from cache: $profile');

      return profile;
    } catch (e) {
      Logger.log('[ProfileLocalDataSource] Error clearing cached profile: $e');

      rethrow;
    }
  }

  @override
  Future<void> cacheProfile(UserProfile profile) async {
    try {
      await _userProfileBox.put(_currentUserProfileKey, profile);
      Logger.log('[ProfileLocalDataSource] Profile cached: $profile');
    } catch (e) {
      Logger.log('[ProfileLocalDataSource] Error caching profile: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearCachedProfile() async {
    try {
      if (_userProfileBox.isOpen) {
        await _userProfileBox.delete(_currentUserProfileKey);
        Logger.log('[ProfileLocalDataSource] Cached profile cleared.');
      }
    } catch (e) {
      Logger.log('[ProfileLocalDataSource] Error clearing cached profile: $e');
      rethrow;
    }
  }
}
