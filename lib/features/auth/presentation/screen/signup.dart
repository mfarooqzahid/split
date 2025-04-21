import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SignupBottomSheet extends StatelessWidget {
  const SignupBottomSheet({
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
              "Create an account",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.mail),
                      hintText: "e.g. Jhon Deo",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.mail),
                      hintText: "e.g. jhon@email.com",
                    ),
                  ),
                ],
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
