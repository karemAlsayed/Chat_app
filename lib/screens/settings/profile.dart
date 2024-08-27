import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = 'Name';
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
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(Iconsax.user),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Center(
                          child: IconButton.filled(
                            onPressed: () {},
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
                          onPressed: () {}, icon: const Icon(Iconsax.edit)),
                      title: TextField(
                        controller: nameController,
                        enabled: false,
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
                          onPressed: () {}, icon: const Icon(Iconsax.edit)),
                      title: TextField(
                        controller: nameController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'About',
                        ),
                      )),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Iconsax.direct),
                    title: Text('Email'),
                    subtitle: Text('Email@gmail.com'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Iconsax.timer),
                    title: Text('Join Date'),
                    subtitle: Text('dd/mm/yyyy'),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
