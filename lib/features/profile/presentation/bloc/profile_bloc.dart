import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:split/features/profile/data/model/user_profile.dart';
import 'package:split/features/profile/data/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryImpl profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }
  Future<void> _onFetchProfile(FetchProfile event, Emitter emit) async {
    emit(ProfileLoading());

    final result = await profileRepository.getUserProfile(event.userId);

    result.fold(
      (failure) {
        emit(ProfileFailure(failure.message));
      },
      (userProfile) {
        if (userProfile == null) {
          emit(ProfileIncomplete());
        } else {
          emit(ProfileSuccess(userProfile));
        }
      },
    );
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter emit) async {
    emit(ProfileLoading());

    final result = await profileRepository.updateUserProfile(
      userId: event.userId,
      userName: event.userName,
      email: event.email,
      profileUrl: event.profileUrl,
    );

    result.fold(
      (failure) {
        emit(ProfileFailure(failure.message));
      },
      (profile) {
        emit(ProfileSuccess(profile));
      },
    );
  }

  // Future<void> _onClearProfileCache(
  //     ClearProfileCache event, Emitter emit) async {
  //   emit(ProfileLoading());
  //   final result = await profileRepository.clearLocalProfile();
  //   result.fold(
  //     (failure) => emit(ProfileFailure(failure.message)),
  //     (success) => emit(ProfileCachedCleared()),
  //   );
  // }
}
