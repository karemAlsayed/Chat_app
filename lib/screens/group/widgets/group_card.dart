




import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/screens/group/group_screen.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key, required this.group,
  });
  final GroupRoom group;

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: ListTile(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => GroupScreen(
             chatGroup: group,
           )));
        },
        leading:  CircleAvatar(
          child: Text(group.name![0].toUpperCase()),
        ),
        title:  Text(group.name!),
        subtitle:  Text(group.lastMessage??'Start Conversation', maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Badge(
          padding: EdgeInsets.symmetric(horizontal: 12),
          label: Text('3'),
          largeSize: 30,
        ),
      ),
    );
  }
}
