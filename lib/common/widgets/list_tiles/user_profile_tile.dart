import 'package:flutter/material.dart';
import '../../../features/personalisation/controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const Icon(
        Icons.person,
        color: CustomColors.secondary,
        size: 40,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: CustomColors.white),
      ),
      subtitle: Text(
        'ID: ${controller.user.value.userId}',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.white),
      ),
    );
  }
}
