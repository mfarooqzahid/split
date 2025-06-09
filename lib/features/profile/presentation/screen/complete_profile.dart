import 'dart:math';

import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/utils/logger.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:split/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompleteProfileScreen extends StatefulWidget {
  final bool isEditing;
  final User user;
  const CompleteProfileScreen(
      {super.key, required this.user, this.isEditing = false});
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late Avatar avatar;
  late TextEditingController userNameController;
  late bool isEditing;

  void _generateNewAvatar() {
    final random = Random();
    setState(() {
      avatar = DiceBearBuilder.withRandomSeed(
        radius: 50,
        backgroundColor:
            Color(_backgroundColors[random.nextInt(_backgroundColors.length)]),
        sprite: DiceBearSprite.avataaars,
      ).build();
      Logger.log('Generated avatar: ${avatar.svgUri.toString()}');
    });
  }

  @override
  void initState() {
    isEditing = widget.isEditing;
    final String email = widget.user.email!;
    userNameController = TextEditingController(text: email.split("@")[0]);

    if (isEditing) {
      _generateNewAvatar();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        Logger.log(state.toString());
        if (state is ProfileSuccess) {
          context.goNamed('home');
        }
      },
      builder: (context, state) {
        if (isEditing && state is ProfileSuccess) {
          userNameController.text = state.profile.name;
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(localization.completeProfile),
            ),
            body: DefaultStyledContainer(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  ClipOval(
                    child: ColoredBox(
                      color: Colors.grey.withAlpha(30),
                      child: SizedBox.square(
                        dimension: 100,
                        child: isEditing
                            ? state is ProfileSuccess
                                ? SvgPicture.network(state.profile.profileUrl)
                                : null
                            : avatar.toImage(),
                      ),
                    ),
                  ),
                  TextField(
                    controller: userNameController,
                    enabled: state is! ProfileLoading,
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    onPressed: state is ProfileLoading
                        ? null
                        : () {
                            setState(() {
                              isEditing = false; // local variable
                              _generateNewAvatar();
                            });
                          },
                    child: Text(localization.generateNewAvatar),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    onPressed: state is ProfileLoading
                        ? null
                        : () {
                            if (userNameController.text.trim().isNotEmpty) {
                              context.read<ProfileBloc>().add(UpdateProfile(
                                    userId: widget.user.id,
                                    email: widget.user.email!,
                                    userName: userNameController.text.trim(),
                                    profileUrl: isEditing
                                        ? (state as ProfileSuccess)
                                            .profile
                                            .profileUrl
                                        : avatar.svgUri.toString(),
                                  ));
                            }
                          },
                    child: Text(localization.saveProfile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static final List<int> _backgroundColors = [
    0xFFff6b6b,
    0xFF4ecdc4,
    0xFF45b7d1,
    0xFF96ceb4,
    0xFFfeca57,
    0xFFff9ff3,
    0xFFa55eea,
    0xFFfd79a8,
    0xFF00b894,
    0xFFfdcb6e,
    0xFF6c5ce7,
    0xFFfd7272,
    0xFF00cec9,
    0xFFa29bfe,
    0xFFffc107,
  ];
}
