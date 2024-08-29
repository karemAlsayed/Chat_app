





import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMessageCard extends StatelessWidget {
  const GroupMessageCard({
    super.key, required this.index, required this.message,
  });
  
  final Message message;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isMe = message.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Row(
      mainAxisAlignment: isMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        isMe
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.message_edit))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: const Radius.circular(16),
              bottomLeft: const Radius.circular(16),
              topRight:
                  Radius.circular(isMe ? 0 : 16),
            ),
          ),
          color: isMe
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   isMe ? const SizedBox() : StreamBuilder(
                     stream: FirebaseFirestore.instance.collection('users').doc(message.fromId).snapshots(),
                     builder: (context, snapshot) {
                       return snapshot.hasData ?Text(
                        snapshot.data!.data()!['name'],
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                                         ):Container();
                     }
                   ),
                   Text(
                      message.msg!),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isMe
                          ? const Icon(Iconsax.tick_circle,
                              color: Colors.grey)
                          : const SizedBox(),
                      const SizedBox(width: 8),
                      Text(
                        message.createdAt!,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
