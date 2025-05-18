import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          if (state is AuthSuccess) {
            // TODO: handle auth success state
            Logger.log("OTP verified");
          }

          if (state is AuthError) {
            // TODO: handle auth error state
            Logger.log(state.message);
          }
        },
        builder: (context, state) {
          return AnimatedPadding(
            duration: Durations.short4,
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "_ _ _ _ _ _",
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        // Text(
                        //   // TODO: Handle error messsage
                        //   "Error: ",
                        //   style: TextStyle(color: Colors.red),
                        // ),
                      ],
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
            ),
          );
        },
      ),
    );
  }
}
