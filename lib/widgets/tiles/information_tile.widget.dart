import 'package:flutter/material.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    Key? key,
    required this.onTap,
    required this.picture,
    required this.subtitle,
    required this.name,
  }) : super(key: key);

  final Widget picture;
  final String name;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ListTile(
        leading: picture,
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(subtitle),
        visualDensity:
            const VisualDensity(vertical: VisualDensity.maximumDensity),
        minVerticalPadding: 16,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28),
        horizontalTitleGap: 16,
      ),
    );
  }
}
