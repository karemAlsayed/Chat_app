import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/group/widgets/group_member.dart';
import 'package:chat_app/screens/group/widgets/group_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.chatGroup});
  final GroupRoom chatGroup;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

bool typing = false;

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatGroup.name!),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('id', whereIn: widget.chatGroup.members!)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List members = [];
                    for (var element in snapshot.data!.docs) {
                      members.add(element.data()['name']);
                    }
                    return Text(
                      members.join(', '),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    );
                  }
                  return const Text('no members');
                })
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  GroupMemberScreen(
                    chatGroup: widget.chatGroup,
                  ),
                ),
              );
            },
            icon: const Icon(Iconsax.people),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('groups')
                      .doc(widget.chatGroup.id)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Message> msgs = snapshot.data!.docs
                          .map(
                            (e) => Message.fromJson(e.data()),
                          )
                          .toList()
                        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                      if (msgs.isNotEmpty) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: msgs.length,
                            itemBuilder: (context, index) {
                              return GroupMessageCard(
                                message: msgs[index],
                                index: index,
                              );
                            });
                      } else {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              FireData()
                                  .sendGMessage('Hi!', widget.chatGroup.id!);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
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
                                    onPressed: () {},
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
                          .sendGMessage(
                              messageController.text, widget.chatGroup.id!)
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
