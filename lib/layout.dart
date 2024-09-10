import 'package:chat_app/firebase/fire_auth.dart';
import 'package:chat_app/provider/provider.dart';
import 'package:chat_app/screens/home/chat_home_screen.dart';
import 'package:chat_app/screens/home/contacts_homescreen.dart';

import 'package:chat_app/screens/home/settings_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({super.key});

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

int selectedIndex = 0;

class _LayoutAppState extends State<LayoutApp> {
  @override
  void initState() {
    Provider.of<ProviderApp>(context, listen: false).getValuePreference();
    Provider.of<ProviderApp>(context, listen: false).getUserDetails();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (message == AppLifecycleState.resumed.toString()) {
        FireAuth().updateActivate(true);
        
      }else if (message == AppLifecycleState.inactive.toString()||message == AppLifecycleState.paused.toString()) {
        FireAuth().updateActivate(false);
        
      }

      return Future.value(message);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const [
      ChatHomeScreen(),
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
            NavigationDestination(
                icon: Icon(Iconsax.people), label: 'Contacts'),
            NavigationDestination(
                icon: Icon(Iconsax.setting), label: 'Settings'),
          ]),
    );
  }
}
