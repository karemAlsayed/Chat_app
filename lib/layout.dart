import 'package:chat_app/screens/home/chat_home_screen.dart';
import 'package:chat_app/screens/home/contacts_homescreen.dart';
import 'package:chat_app/screens/home/groups_home_screen.dart';
import 'package:chat_app/screens/home/settings_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({super.key});

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

int selectedIndex = 0;

class _LayoutAppState extends State<LayoutApp> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const[
       
       ChatHomeScreen(),
       GroupsHomeScreen(),
       ContactsHomeScreen(),
       SettingsHomeScreen()
    
    ];
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
            NavigationDestination(icon: Icon(Iconsax.messages), label: 'Groups'),
            NavigationDestination(
                icon: Icon(Iconsax.people), label: 'Contacts'),
            NavigationDestination(icon: Icon(Iconsax.setting), label: 'Settings'),
          ]),
    );
  }
}
