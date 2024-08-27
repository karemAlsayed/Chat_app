import 'package:chat_app/chat/widgets/chat_card.dart';
import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/room_model.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Enter Contact Email :',
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.scan_barcode))
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        label: 'Email',
                        prefixIcon: Iconsax.user,
                        controller: controller,
                        obscureText: false,
                        isPassword: false),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          FireData().createRoom(controller.text).then(
                            (value) {
                              setState(() {
                                controller.text = '';
                              });
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: const Center(
                          child: Text(
                        'Start Chat',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.message_add),
      ),
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .where('members',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      // .orderBy('last_message_time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChatRoom> items = snapshot.data!.docs.map((e) {
                        return ChatRoom.fromJson(e.data());
                      }).toList()..sort( (a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!),);
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return  ChatCard(
                            item: items[index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
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
