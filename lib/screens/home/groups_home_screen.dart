import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/screens/group/create_group.dart';
import 'package:chat_app/screens/group/widgets/group_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateGroup(),
            ),
          );
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('groups')
                      .where('admin',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<GroupRoom> items = snapshot.data!.docs
                          .map(
                            (e) => GroupRoom.fromJson(e.data()),
                          )
                          .toList()..sort(
                            (a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!),
                          );
                      return ListView.builder(
                        itemBuilder: (context, index) =>  GroupCard(
                          group: items[index],
                        ),
                        itemCount: items.length,
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
