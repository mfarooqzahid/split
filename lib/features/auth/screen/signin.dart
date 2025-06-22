import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:split/core/assets/images.dart';
import 'package:split/core/utils/flutter_toast.dart';
import 'package:split/core/utils/validators.dart';
import 'package:split/features/auth/bloc/auth_bloc.dart';
import 'package:split/features/auth/widget/verify_otp.dart';
import '/l10n/app_localizations.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(
    text: kDebugMode ? "farooqinfocus@gmail.com" : null,
  );
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => GetIt.I<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // in case of success show the verify otp bottom sheet
          if (state is AuthSuccess) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              showDragHandle: false,
              enableDrag: false,
              builder: (context) {
                return PopScope(
                  canPop: false,
                  child: VerifyOtpBottomSheet(
                    email: emailController.text.trim(),
                  ),
                );
              },
            );
          }

          // if there is an error, then show the message
          if (state is AuthError) {
            showErrorToast(state.message);
          }
        },
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: LayoutBuilder(builder: (context, constrains) {
              return NotificationListener(
                onNotification: (OverscrollIndicatorNotification notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constrains.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            scale: 5,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            localization.welcomeToSplit,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            localization.pleaseEnterYourEmail,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: formKey,
                            child: TextFormField(
                              controller: emailController,
                              enabled: state is! AuthLoading,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => !emailRegex.hasMatch(value!)
                                  ? localization.pleaseEnterCorrectEmail
                                  : value.isEmpty
                                      ? localization.pleaseEnterAnEmail
                                      : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.mail),
                                hintText: "e.g. jhon@email.com",
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              fixedSize: const Size(double.maxFinite, 50),
                            ),
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(SigninEvent(
                                          email: emailController.text.trim()));
                                    }
                                  },
                            child: Text(localization.sendOtp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
