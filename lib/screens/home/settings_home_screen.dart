
import 'package:chat_app/screens/settings/profile.dart';
import 'package:chat_app/screens/settings/widgets/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';

class SettingsHomeScreen extends StatefulWidget {
  const SettingsHomeScreen({super.key});

  @override
  State<SettingsHomeScreen> createState() => _SettingsHomeScreenState();
}

class _SettingsHomeScreenState extends State<SettingsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                minVerticalPadding: 40,
                leading: const CircleAvatar(
                  radius: 30,
                ),
                title: const Text('Name'),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QrCodeScreen(),
                          ));
                    },
                    icon: const Icon(Iconsax.scan_barcode)),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  title: const Text('Profile'),
                  leading: const Icon(Iconsax.user),
                  trailing: const Icon(Iconsax.arrow_right_3),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Theme'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: Colors.blue,
                                onColorChanged: (value) {},
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        });
                  },
                  title: const Text('Theme'),
                  leading: const Icon(Iconsax.color_swatch),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Dark Mode'),
                  leading: const Icon(Iconsax.magic_star),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
               Card(
                child: ListTile(
                  onTap: () async {
                   await  FirebaseAuth.instance.signOut();
                  
                  },
                  title: const Text('Logout'),
                  trailing: const Icon(Iconsax.logout_1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
