import 'dart:io';

import 'package:chat_app/chat/widgets/chat_message_card.dart';
import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/firebase/fire_storage.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.roomId, required this.chatUser});
  final String roomId;
  final ChatUser chatUser;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

bool typing = false;

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> selectedmsgs = [];
  List<String> copymsgs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatUser.name!),
            Text(
              // widget.chatUser.lastActivated!,
              'Online',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        actions: [
          selectedmsgs.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    FireData().deleteMsg(widget.roomId, selectedmsgs);
                    setState(() {
                      selectedmsgs.clear();
                      copymsgs.clear();
                    });
                  },
                  icon: const Icon(Iconsax.trash),
                )
              : Container(),
          copymsgs.isNotEmpty&&copymsgs.length==1
              ? IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: copymsgs.join('\n')));
                    setState(() {
                      copymsgs.clear();
                      selectedmsgs.clear();
                    });
                  },
                  icon: const Icon(Iconsax.copy),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .doc(widget.roomId)
                      .collection('messages')
                      // .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Message> messageItems = snapshot.data!.docs
                          .map(
                            (e) => Message.fromJson(
                              e.data(),
                            ),
                          )
                          .toList()
                        ..sort(
                          (a, b) {
                            return b.createdAt!.compareTo(a.createdAt!);
                          },
                        );

                      return messageItems.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              itemCount: messageItems.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedmsgs.isNotEmpty
                                          ? selectedmsgs.contains(
                                                  messageItems[index].id)
                                              ? selectedmsgs.remove(
                                                  messageItems[index].id)
                                              : selectedmsgs
                                                  .add(messageItems[index].id!)
                                          : null;
                                      copymsgs.isNotEmpty
                                          ? messageItems[index].type == 'text'
                                              ? copymsgs.contains(
                                                      messageItems[index].msg)
                                                  ? copymsgs.remove(
                                                      messageItems[index].msg)
                                                  : copymsgs.add(
                                                      messageItems[index].msg!)
                                              : null
                                          : null;
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedmsgs
                                              .contains(messageItems[index].id)
                                          ? selectedmsgs
                                              .remove(messageItems[index].id)
                                          : selectedmsgs
                                              .add(messageItems[index].id!);
                                      messageItems[index].type == 'text'
                                          ? copymsgs.contains(
                                                  messageItems[index].msg)
                                              ? copymsgs.remove(
                                                  messageItems[index].msg)
                                              : copymsgs
                                                  .add(messageItems[index].msg!)
                                          : null;
                                    });
                                  },
                                  child: ChatMessageCard(
                                    select: selectedmsgs
                                        .contains(messageItems[index].id),
                                    roomId: widget.roomId,
                                    messageItem: messageItems[index],
                                  ),
                                );
                              })
                          : Center(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      FireData()
                                          .sendMessage(widget.chatUser.id!,
                                              'hi !', widget.roomId)
                                          .then((value) {});
                                    });
                                  },
                                  child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '👋',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'Say hi !',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: messageController,
                      onTapOutside: (event) {
                        setState(() {
                          typing = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                      },
                      onTap: () {
                        setState(() {
                          typing = true;
                        });
                      },
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: typing
                            ? null
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      ImagePicker imagePicker = ImagePicker();
                                      XFile? image =
                                          await imagePicker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (image != null) {
                                        FireStorage().sendImage(
                                          file: File(image.path),
                                          roomId: widget.roomId,
                                          myUid: widget.chatUser.id!,
                                        );
                                      }
                                    },
                                    icon: const Icon(Iconsax.gallery),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Iconsax.camera),
                                  ),
                                ],
                              ),
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      FireData()
                          .sendMessage(widget.chatUser.id!,
                              messageController.text, widget.roomId)
                          .then((value) {
                        setState(() {
                          messageController.clear();
                        });
                      });
                    }
                  },
                  icon: const Icon(Iconsax.send_1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
