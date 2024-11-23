import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SplitApp());
}

class SplitApp extends StatefulWidget {
  const SplitApp({super.key});

  @override
  State<SplitApp> createState() => _SplitAppState();
}

class _SplitAppState extends State<SplitApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
