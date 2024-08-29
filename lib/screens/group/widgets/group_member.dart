import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/group/widgets/group_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key, required this.chatGroup});
  final GroupRoom chatGroup;

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = widget.chatGroup.admin!
        .contains(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Members'),
        actions: !isAdmin
            ? null
            : [
              
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  GroupEditScreen(
                          chatGroup: widget.chatGroup,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Iconsax.edit),
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('id', whereIn: widget.chatGroup.members!)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List< ChatUser> members = snapshot.data!.docs.map((e) =>ChatUser.fromJson(e.data()) ).toList();  
                      return ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          bool isAnAdmin = widget.chatGroup.admin!.contains(
                              members[index].id!);
                          
                          return ListTile(
                              leading: const CircleAvatar(),
                              title:  Text(members[index].name!),
                              subtitle: isAnAdmin? const Text( 'Admin',style: TextStyle(color: Colors.blue), ):const Text('Member'),
                              trailing: isAdmin&&isAnAdmin
                                  ? null
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Iconsax.user_octagon)),
                                        IconButton(
                                            onPressed: () {
                                              FireData().remMember(widget.chatGroup.id!,[ members[index].id ]).then(
                                                (value) {
                                                  setState(() {
                                                    widget.chatGroup.members!.remove(members[index].id!);
                                                  });
                                                },
                                              );
                                            },
                                            icon: const Icon(Iconsax.trash)),
                                      ],
                                    ));
                        },
                      );
                    } else {
                      return const Text('no members');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
