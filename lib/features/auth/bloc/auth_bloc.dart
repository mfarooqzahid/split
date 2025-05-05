import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:split/features/auth/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({
    required this.authRepo,
  }) : super(AuthInitial()) {
    on<SigninEvent>(_onSigninEvent);
    on<VerifyOTPEvent>(_onVerifyOTPEvent);
  }

  _onSigninEvent(SigninEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await authRepo.signInWithEmailOtp(email: event.email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) => emit(AuthSuccess()),
    );
  }

  _onVerifyOTPEvent(VerifyOTPEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await authRepo.verifyOTP(
      email: event.email,
      token: event.otp,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResponse) {},
    );
  }
}
