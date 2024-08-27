import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/models/room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.item,
  });
  final ChatRoom item;

  @override
  Widget build(BuildContext context) {
    String userId = item.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .first;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
            ChatUser chatUser = ChatUser.fromJson(snapshot.data!.data()!);
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                roomId: item.id!,
                                chatUser: chatUser,
                              )));
                },
                leading: const CircleAvatar(),
                title:  Text( chatUser.name!),
                subtitle:  Text(item.lastMessage! == '' ? chatUser.about! : item.lastMessage!),
                trailing: 1 / 1 != 0
                    ? const Badge(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        label: Text('3'),
                        largeSize: 30,
                      )
                    : Text(item.lastMessageTime!),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
