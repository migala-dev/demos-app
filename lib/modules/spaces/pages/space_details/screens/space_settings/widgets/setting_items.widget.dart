import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28),
        horizontalTitleGap: 8,
      ),
    );
  }
}
