part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final  class FetchProfile extends ProfileEvent {
  final String userId;

  const FetchProfile(this.userId);

  @override
  List<Object> get props => [userId];
}