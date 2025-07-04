import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '/l10n/app_localizations.dart';
import 'package:split/core/utils/flutter_toast.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/features/auth/bloc/auth_bloc.dart';

class VerifyOtpBottomSheet extends StatefulWidget {
  final String email;
  const VerifyOtpBottomSheet({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpBottomSheet> createState() => _VerifyOtpBottomSheetState();
}

class _VerifyOtpBottomSheetState extends State<VerifyOtpBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => GetIt.I<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            // incase of successfull authentication
            // navigate to dashboard screen
            context.pop();
            Logger.log("OTP verified");
            context.goNamed('home');
          }

          if (state is AuthError) {
            // handling the state incase of an error
            // show error toast
            Logger.log(state.message);
            showErrorToast(state.message);
          }
        },
        builder: (context, state) {
          return AnimatedPadding(
            duration: Durations.short4,
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          localization.verifyOtp,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 12,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        onPressed: () =>
                            state is AuthLoading ? null : context.pop(),
                        icon: const Icon(Icons.close, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      // Disable the text field when there is loading
                      enabled: state is! AuthLoading,
                      controller: otpController,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "_ _ _ _ _ _",
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 45),
                    ),
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(VerifyOTPEvent(
                                  email: widget.email,
                                  otp: otpController.text.trim(),
                                ));
                          },
                    child: Text(localization.verifyOtp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
