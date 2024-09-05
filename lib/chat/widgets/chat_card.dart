import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.item,
  });
  final ChatRoom item;

  @override
  Widget build(BuildContext context) {
    List member = item.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .toList();
    String userId =
        member.isEmpty ? FirebaseAuth.instance.currentUser!.uid : member.first;
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
                  leading: chatUser.image == ''
                      ? const CircleAvatar(
                          radius: 30,
                          child: Icon(Iconsax.user),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(chatUser.image!),
                        ),
                  title: Text(chatUser.name!),
                  subtitle: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      item.lastMessage! == ''
                          ? chatUser.about!
                          : item.lastMessage!),
                  trailing: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('rooms')
                          .doc(item.id!)
                          .collection('messages')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final unreadList = snapshot.data?.docs
                                  .map((e) => Message.fromJson(e.data()))
                                  .where((element) => element.read == '')
                                  .where((element) =>
                                      element.fromId !=
                                      FirebaseAuth.instance.currentUser!.uid) ??
                              [];
                          return unreadList.isNotEmpty
                              ? Badge(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  label: Text(unreadList.length.toString()),
                                  largeSize: 30,
                                )
                              : const SizedBox();
                          // : Text(DateFormat.yMMMEd()
                          //     .format(
                          //       DateTime.fromMillisecondsSinceEpoch(
                          //         int.parse(
                          //           item.lastMessageTime!.toString(),
                          //         ),
                          //       ),
                          //     )
                          //     .toString());
                        } else {
                          return const SizedBox();
                        }
                      })),
            );
          } else {
            return Container();
          }
        });
  }
}
