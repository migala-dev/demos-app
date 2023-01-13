import 'package:flutter/material.dart';

class RequestToJoin extends StatefulWidget {
  final String? spaceId;

  const RequestToJoin({Key? key, this.spaceId}) : super(key: key);

  @override
  State<RequestToJoin> createState() => _RequestToJoinState();
}

class _RequestToJoinState extends State<RequestToJoin> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('SpaceId: ${widget.spaceId}'));
  }
}