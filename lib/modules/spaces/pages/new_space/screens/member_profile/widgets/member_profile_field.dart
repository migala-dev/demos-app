import 'package:flutter/material.dart';

class MemberProfileField extends StatelessWidget {
  const MemberProfileField(
      {Key? key, required this.title, required this.child, required this.icon})
      : super(key: key);

  final String title;
  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        subtitle: child);
  }
}
