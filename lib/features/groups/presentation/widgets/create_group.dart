import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/core.dart';
import 'package:split/features/groups/groups.dart';
import 'package:split/l10n/app_localizations.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({super.key});

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  late TextEditingController groupNameController;
  Avatar? avatar;

  @override
  void initState() {
    groupNameController = TextEditingController();
    _generateNewAvatar();
    super.initState();
  }

  void _generateNewAvatar() {
    setState(() {
      avatar = AvatarGenerator.generate(sprite: DiceBearSprite.bottts);
    });
  }

  void _createGroup() {
    final name = groupNameController.text.trim();
    if (name.isNotEmpty && avatar != null) {
      final groupData = {
        'name': name,
        'avatar': avatar!.svgUri.toString(),
      };
      // TODO: Call your repository or BLoC to save this group
      Logger.log("Group Created: $groupData");
      Navigator.of(context).pop(); // close bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add localized text
    final localizations = AppLocalizations.of(context)!;
    return BlocConsumer<GroupsBloc, GroupsState>(
      listener: (context, state) {
        if (state is GroupSuccess) {
          // move to group info screen, basically where the admin can add memebers
          context.goNamed('group-');
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarDisplay(child: avatar?.toImage()),
            const SizedBox(height: 20),
            TextField(
              controller: groupNameController,
              decoration: const InputDecoration(hintText: "Group Name"),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: _generateNewAvatar,
              style: FilledButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 50),
              ),
              child: Text(localizations.generateNewAvatar),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: _createGroup,
              style: FilledButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 50),
              ),
              child: const Text("Create Group"),
            ),
          ],
        );
      },
    );
  }
}
