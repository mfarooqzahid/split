part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SigninEvent extends AuthEvent {
  final String email;
  const SigninEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class VerifyOTPEvent extends AuthEvent {
  final String email;
  final String otp;

  const VerifyOTPEvent({required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}
