import 'dart:io';

import 'package:chat_app/firebase/fire_database.dart';
import 'package:chat_app/firebase/fire_storage.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  ChatUser? me;
  String imageUrl = '';
  bool nameEdit = false;
  bool aboutEdit = false;
  @override
  void initState() {
    me = Provider.of<ProviderApp>(context, listen: false).me;
    super.initState();
    nameController.text = me!.name ?? 'Name';
    aboutController.text = me!.about ?? 'About';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      imageUrl == ''
                          ? me!.image == ''
                              ? const CircleAvatar(
                                  radius: 50,
                                  child: Icon(Iconsax.user),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(me!.image!),
                                )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(File(imageUrl)),
                            ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Center(
                          child: IconButton.filled(
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? image = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  imageUrl = image.path;
                                });
                                FireStorage().updateProfilePic(
                                  file: File(image.path),
                                );
                              }
                            },
                            icon: const Icon(Iconsax.gallery_add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: ListTile(
                      leading: const Icon(Iconsax.user),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              nameEdit = !nameEdit;
                            });
                          },
                          icon: const Icon(Iconsax.edit)),
                      title: TextField(
                        controller: nameController,
                        enabled: nameEdit,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Name',
                        ),
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Icon(Iconsax.info_circle),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              aboutEdit = !aboutEdit;
                            });
                          },
                          icon: const Icon(Iconsax.edit)),
                      title: TextField(
                        controller: aboutController,
                        enabled: aboutEdit,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'About',
                        ),
                      )),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Iconsax.direct),
                    title: const Text('Email'),
                    subtitle: Text(me!.email ?? 'Email'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Iconsax.timer),
                    title: const Text('Join Date'),
                    subtitle: Text(me!.createdAt.toString()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    FireData().editProfile(nameController.text, aboutController.text).then(
                      (value) {
                        setState(() {
                          nameEdit = false;
                          aboutEdit = false;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
