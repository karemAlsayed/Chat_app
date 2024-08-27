

import 'package:chat_app/screens/group/widgets/group_edit.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key});

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Members'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.user_cirlce_add),),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupEditScreen(),),);
          }, icon: const Icon(Iconsax.edit),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: const CircleAvatar(),
                    title: const Text('Name'),
                    subtitle: const Text('Admin'),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Iconsax.user_octagon)),
                        IconButton(onPressed: () {}, icon: const Icon(Iconsax.trash)),
                        
                      ],
                    )
                  );
                },
                 ),
            ),
          ],
        ),
      ),
    );
  }
}