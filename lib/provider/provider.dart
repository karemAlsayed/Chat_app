import 'package:chat_app/firebase/fire_auth.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderApp with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  int mainColor = 0xff405085;
  ChatUser? me;

  getUserDetails() async {
    String myId = FirebaseAuth.instance.currentUser!.uid;
   await  FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .get()
        .then((value) {
      me = ChatUser.fromJson(value.data()!);
    });
    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        me!.pushToken = value;
        FireAuth().getToken(value);
      }
    });
    notifyListeners();
  }

  changeMode(bool dark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', themeMode == ThemeMode.dark);
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  changeColor(int color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    mainColor = color;
    prefs.setInt('color', mainColor);

    notifyListeners();
  }

  getValuePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDark = prefs.getBool('dark') ?? false;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    mainColor = prefs.getInt('color') ?? 0xff405085;
    notifyListeners();
  }
}
