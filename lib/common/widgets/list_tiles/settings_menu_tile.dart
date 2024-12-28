import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.secondary),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style:
            Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
