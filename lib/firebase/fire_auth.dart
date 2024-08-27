import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

 static  User user = auth.currentUser!;

  static Future createUser() async {
    ChatUser chatUser = ChatUser(
      id: user.uid,
      name: user.displayName??'',
      email: user.email??'',
      about: 'Hey, I am using ChatApp',
      image: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
      pushToken: '',
      online: false,
    );
    await  firebaseFirestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  
}
