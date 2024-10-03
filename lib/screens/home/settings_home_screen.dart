import 'package:chat_app/firebase/fire_auth.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/provider/provider.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/settings/profile.dart';

import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsHomeScreen extends StatefulWidget {
  const SettingsHomeScreen({super.key});

  @override
  State<SettingsHomeScreen> createState() => _SettingsHomeScreenState();
}

class _SettingsHomeScreenState extends State<SettingsHomeScreen> {
  ChatUser? me;
  @override
  Widget build(BuildContext context) {
    
    final prov = Provider.of<ProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(
                child: 
                prov.me?.image == ''?
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Iconsax.user),
                )
               :CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(prov.me?.image ?? ''),
                        )
                      ,
                  
                
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
              prov.me?.name ?? 'Name',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  prov.me?.email ?? 'No Email',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith( color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
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
                                pickerColor: Color(prov.mainColor),
                                onColorChanged: (value) {
                                  prov.changeColor(value.value);
                                },
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
                    value: prov.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      prov.changeMode(value);
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                
                  onTap: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      animType: CoolAlertAnimType.slideInDown,
                      confirmBtnColor: Colors.red,
                    
                      text: 'Are you sure you want to logout?',
                      onConfirmBtnTap: () {
                        
                        FireAuth.auth.signOut().then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        });
                        
                      },
                    );
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
