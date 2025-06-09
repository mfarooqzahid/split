import 'package:split/core/error/failure.dart';
import 'package:split/core/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

class AuthRepo {
  final SupabaseClient supabase;

  const AuthRepo({required this.supabase});

  /// Sends a one-time password (OTP) to the provided email.
  Future<Either<Failure, void>> signInWithEmailOtp({
    required String email,
  }) async {
    Logger.log('[AuthRepo] Sending OTP to $email');
    try {
      await supabase.auth.signInWithOtp(email: email);
      Logger.log('[AuthRepo] OTP sent successfully to $email');
      return right(null);
    } on AuthException catch (e) {
      Logger.log('[AuthRepo] AuthException while sending OTP: ${e.message}');
      return left(Failure(message: e.message));
    } catch (e) {
      Logger.log('[AuthRepo] Unknown error while sending OTP: $e');
      return left(const Failure());
    }
  }

  /// Verifies the OTP sent to the provided email.
  Future<Either<Failure, AuthResponse>> verifyOTP({
    required String email,
    required String token,
  }) async {
    Logger.log('[AuthRepo] Verifying OTP for $email');
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: token,
      );
      Logger.log('[AuthRepo] OTP verified successfully for $email');
      return right(response);
    } on AuthException catch (e) {
      Logger.log('[AuthRepo] AuthException while verifying OTP: ${e.message}');
      return left(Failure(message: e.message));
    } catch (e) {
      Logger.log('[AuthRepo] Unknown error while verifying OTP: $e');
      return left(const Failure());
    }
  }
}
