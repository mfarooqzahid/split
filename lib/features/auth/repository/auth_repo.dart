import 'package:split/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

class AuthRepo {
  final SupabaseClient supabase;
  const AuthRepo({required this.supabase});
  Future<Either<Failure, void>> signInWithEmailOtp({
    required String email,
  }) async {
    try {
      await supabase.auth.signInWithOtp(email: email);
      return right(null);
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    }
  }

  Future<Either<Failure, AuthResponse>> verifyOTP({
    required String email,
    required String token,
  }) async {
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: token,
      );
      return right(response);
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    }
  }
}
