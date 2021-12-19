import 'package:flutter/material.dart';

class ProposalContent extends StatelessWidget {
  const ProposalContent({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconAction,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback iconAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          onPressed: iconAction,
        ),
        contentPadding: const EdgeInsets.only(left: 12),
      ),
    );
  }
}
