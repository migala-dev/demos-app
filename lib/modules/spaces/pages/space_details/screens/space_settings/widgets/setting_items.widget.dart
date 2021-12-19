import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: color),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: color),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28),
        horizontalTitleGap: 8,
        dense: true,
      ),
    );
  }
}
