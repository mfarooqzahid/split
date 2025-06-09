part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// Initial state before anything happens
final class ProfileInitial extends ProfileState {}

// When fetching the profile from the database
final class ProfileLoading extends ProfileState {}

// When the profile is successfully fetched but is incomplete
final class ProfileIncomplete extends ProfileState {}

// When the profile is successfully fetched and is complete
final class ProfileSuccess extends ProfileState {
  final UserProfile profile;

  const ProfileSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Optionally: if fetching fails
final class ProfileFailure extends ProfileState {
  final String error;

  const ProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// final class ProfileCachedCleared extends ProfileState {}
