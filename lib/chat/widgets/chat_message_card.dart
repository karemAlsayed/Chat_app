import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatefulWidget {
  const ChatMessageCard({
    super.key,
    required this.messageItem,
    required this.roomId, required this.select,
  });
  final Message messageItem;
  final String roomId;
  final bool select;

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  @override
  void initState() {
    if (widget.messageItem.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireData().readMessage(
        widget.roomId,
        widget.messageItem.id!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMe =
        widget.messageItem.fromId == FirebaseAuth.instance.currentUser!.uid;

    return Container(
      decoration: BoxDecoration(
          color: widget.select? Colors.grey:Colors.transparent, borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe
              ? IconButton(
                  onPressed: () {}, icon: const Icon(Iconsax.message_edit))
              : const SizedBox(),
          const SizedBox(
            width: 5,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: const Radius.circular(16),
                bottomLeft: const Radius.circular(16),
                topRight: Radius.circular(isMe ? 0 : 16),
              ),
            ),
            color: isMe
                ? Theme.of(context).colorScheme.surfaceBright
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
                    widget.messageItem.type == 'image'
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.messageItem.msg!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            widget.messageItem.msg!,
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.yMMMd('en_US')
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(widget.messageItem.createdAt!)))
                              .toString(),
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        isMe
                            ? Icon(Iconsax.tick_circle,
                                color: widget.messageItem.read == ''
                                    ? Colors.grey
                                    : Colors.blue)
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
