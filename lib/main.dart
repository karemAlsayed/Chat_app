import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/layout.dart';
import 'package:chat_app/provider/provider.dart';

import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/auth/setup_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderApp(),
      child: Consumer <ProviderApp>(builder: (context, value, child) {
        return MaterialApp(
            themeMode: value.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor:Color(value.mainColor),
                  brightness: Brightness.light),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(value.mainColor), brightness: Brightness.dark),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (FirebaseAuth.instance.currentUser!.displayName ==
                        null) {
                      return const SetupProfile();
                    } else {
                      return const LayoutApp();
                    }
                  } else {
                    return const LoginScreen();
                  }
                }));
      }),
    );
  }
}
