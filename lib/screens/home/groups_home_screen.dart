import 'package:chat_app/screens/group/create_group.dart';
import 'package:chat_app/screens/group/widgets/group_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupsHomeScreen extends StatefulWidget {
  const GroupsHomeScreen({super.key});

  @override
  State<GroupsHomeScreen> createState() => _GroupsHomeScreenState();
}

class _GroupsHomeScreenState extends State<GroupsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGroup(),),);
        },
        child: const Icon(Iconsax.message_add),
      ),
      appBar: AppBar(
        title: const Text('groups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(

                itemBuilder: (context, index) => const GroupCard(),
                itemCount: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
