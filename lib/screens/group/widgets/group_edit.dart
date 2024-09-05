import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupEditScreen extends StatefulWidget {
  const GroupEditScreen({super.key, required this.chatGroup});

  final GroupRoom chatGroup;

  @override
  State<GroupEditScreen> createState() => _GroupEditScreenState();
}

class _GroupEditScreenState extends State<GroupEditScreen> {
  TextEditingController controller = TextEditingController();
  List members = [];
  List myContacts = [];
  @override
  void initState() {
    
    super.initState();
    controller.text = widget.chatGroup.name!;
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      floatingActionButton: 
           FloatingActionButton.extended(
              onPressed: () {
                FireData().editGroup(controller.text==''? 'Group' : controller.text, widget.chatGroup.id!, members).then(
                  (value) {
                    
                    Navigator.pop(context);
                    
                  },
                );
              },
              label: const Text('Done'),
              icon: const Icon(Iconsax.tick_circle)),
      appBar: AppBar(
        title: const Text('Group Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                    ),
                    Positioned(
                      bottom: -0,
                      right: -0,
                      left: 0,
                      top: 0,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.gallery_add),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomTextField(
                    
                      
                        label: 'Group Name',
                      
                        prefixIcon: Iconsax.user,
                        controller: controller,
                        obscureText: false,
                        isPassword: false,

                        ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Add Members',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const Spacer(),
                Text(
                  members.length.toString(),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      myContacts = snapshot.data!.data()!['my_users'];

                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('id',
                                  whereIn:
                                      myContacts.isEmpty ? [''] : myContacts)
                                      
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<ChatUser> items = snapshot.data!.docs
                                  .map((e) => ChatUser.fromJson(e.data()))
                                  .where(
                                    (element) =>
                                        element.id !=
                                        FirebaseAuth.instance.currentUser!.uid,
                                  ).where((element) => !widget.chatGroup.members!.contains(element.id),)
                                  .toList()
                                ..sort(
                                  (a, b) => a.name!.compareTo(b.name!),
                                );
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    checkboxShape: const CircleBorder(),
                                    title: Text(items[index].name!),
                                    value: members.contains(items[index].id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value!) {
                                          members.add(items[index].id!);
                                        } else {
                                          members.remove(items[index].id!);
                                        }
                                      });
                                    },
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Container(),
                              );
                            }
                          });
                    } else {
                      return Center(
                        child: Container(),
                      );
                    }
                  }),
              
            )
          ],
        ),
      ),
    );
  }
}
