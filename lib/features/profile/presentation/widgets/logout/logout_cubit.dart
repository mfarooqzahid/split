// logout_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:split/features/profile/data/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutError extends LogoutState {
  final String message;
  const LogoutError(this.message);

  @override
  List<Object> get props => [message];
}

class LogoutCubit extends Cubit<LogoutState> {
  final ProfileRepository profileRepository;

  LogoutCubit({required this.profileRepository}) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      // Clear profile cache through repository
      await profileRepository.clearLocalProfile();

      // Then logout
      await Supabase.instance.client.auth.signOut();
      emit(LogoutSuccess());
    } on AuthException catch (e) {
      emit(LogoutError(e.message));
    } catch (e) {
      emit(const LogoutError('An unexpected error occurred'));
    }
  }
}
