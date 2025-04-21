import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "assets/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surface,
                  theme.colorScheme.surface,
                  theme.colorScheme.surface.withAlpha(20),
                ],
              ),
            ),
          )),
        ],
      ),
      // bottomSheet: AnimatedSwitcher(
      //   duration: Durations.extralong1,
      //   child: SigninBottomSheet(theme: theme),
      // ),
    );
  }
}

class SigninBottomSheet extends StatelessWidget {
  const SigninBottomSheet({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              "Login to your account",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.mail),
                  hintText: "e.g. jhon@email.com",
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () {},
              child: const Text("Login"),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed("signup");
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an acoount? ",
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: "Create account",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
