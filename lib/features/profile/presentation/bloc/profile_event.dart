part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FetchProfile extends ProfileEvent {
  final String userId;

  const FetchProfile(this.userId);

  @override
  List<Object> get props => [userId];
}

final class UpdateProfile extends ProfileEvent {
  final String userId;
  final String userName;
  final String email;
  final String profileUrl;
  const UpdateProfile({
    required this.userId,
    required this.email,
    required this.userName,
    required this.profileUrl,
  });

  @override
  List<Object> get props => [userId, userName, email, profileUrl];
}
