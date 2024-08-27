import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myUid = FirebaseAuth.instance.currentUser!.uid;

  Future createRoom(String email) async {
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myUid, userId]..sort(
          (a, b) => a.compareTo(b),
        );
      QuerySnapshot roomExist = await firestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();
      if (roomExist.docs.isEmpty) {
        ChatRoom chatRoom = ChatRoom(
          id: members.toString(),
          createdAt: DateTime.now().toString(),
          lastMessage: '',
          lastMessageTime: DateTime.now().toString(),
          members: members,
        );

        await firestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoom.toJson());
      }
    }
  }

  sendMessage( String uId, String msg, String roomId) async {
    String msgId = const Uuid().v1();
    Message message = Message(

      id: msgId,
      toId: uId,
      fromId: myUid,
      msg: msg,
      type: 'text',
      createdAt: DateTime.now().toString(),
      read: '',
    );

   await  firestore.collection('rooms').doc(roomId).collection('messages').doc(msgId).set(message.toJson());
  }
}
