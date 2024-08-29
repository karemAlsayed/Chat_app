import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactsHomeScreen extends StatefulWidget {
  const ContactsHomeScreen({super.key});

  @override
  State<ContactsHomeScreen> createState() => _ContactsHomeScreenState();
}

class _ContactsHomeScreenState extends State<ContactsHomeScreen> {
  bool searched = false;
  List myContacts = [];
  TextEditingController controller = TextEditingController();
  TextEditingController searchController = TextEditingController();

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
                        FireData().addContact(controller.text).then((value) {
                          setState(() {
                            controller.text = '';
                          });

                          Navigator.pop(context);
                        });
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
                        'Add Contact',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.user_add),
      ),
      appBar: AppBar(
        actions: searched
            ? [
                IconButton(
                    onPressed: () {
                      setState(() {
                        searched = !searched;
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Iconsax.close_circle)),
              ]
            : [
                IconButton(
                    onPressed: () {
                      setState(() {
                        searched = !searched;
                      });
                    },
                    icon: const Icon(Iconsax.search_normal)),
              ],
        title: searched
            ? Row(
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchController.text = value;
                      });
                    },
                    autofocus: true,
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )),
                  ))
                ],
              )
            : const Text('contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                                (element) {
                                  return element.name!.toLowerCase().startsWith(
                                      searchController.text.toLowerCase());
                                },
                              ).toList()
                                ..sort(
                                  (a, b) => a.name!.compareTo(b.name!),
                                );
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ContactCard(
                                    user: items[index],
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

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.user,
  });
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name!),
        leading: const CircleAvatar(),
        subtitle: Text(
          user.email!,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
            onPressed: () {
              List<String> members = [
                user.id!,
                FirebaseAuth.instance.currentUser!.uid
              ]..sort(
                  (a, b) => a.compareTo(b),
                );
              FireData().createRoom(user.email!).then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatUser: user,
                          roomId: members.toString(),
                        ),
                      ),
                    ),
                  );
            },
            icon: const Icon(Iconsax.message)),
      ),
    );
  }
}
