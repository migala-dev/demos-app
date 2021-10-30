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
      margin: EdgeInsets.only(top: 8),
      child: ListTile(
        leading: Icon(this.icon, size: 32),
        title: Text(
          this.title,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          this.subtitle,
          style: TextStyle(fontSize: 12),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 28),
        horizontalTitleGap: 8,
      ),
    );
  }
}
