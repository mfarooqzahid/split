part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SigninEvent extends AuthEvent {
  final String email;
  final String password;
  const SigninEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  const SignupEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
