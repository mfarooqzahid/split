import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:split/features/profile/model/user.dart';
import 'package:split/features/profile/repository/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchUserProfile);
  }
  Future<void> _onFetchUserProfile(FetchProfile event, Emitter emit) async {
    emit(ProfileLoading());

    final result = await profileRepository.fetchUserProfile(event.userId);

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
}
