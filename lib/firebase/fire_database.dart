import 'package:chat_app/models/group_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myUid = FirebaseAuth.instance.currentUser!.uid;
  String now = DateTime.now().millisecondsSinceEpoch.toString();

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
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          lastMessage: '',
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
          members: members,
        );

        await firestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoom.toJson());
      }
    }
  }

  Future createGroup( String name,List  members) async {
    String gId = const Uuid().v1();
    members.add(myUid);
  GroupRoom groupRoom =  GroupRoom(
        id:gId ,
        name: name,
        createdAt: now,
        lastMessage: '',
        lastMessageTime:now,
        members:members,
        admin: [myUid],
        image: '',
        );
        await firestore
            .collection('groups')
            .doc(gId)
            .set(groupRoom.toJson());
  }

  Future addContact(String email) async {
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      firestore.collection('users').doc(myUid).update({
        'my_users': FieldValue.arrayUnion([userId])
      });
    }
  }

  sendMessage(String uId, String msg, String roomId, {String? type}) async {
    String msgId = const Uuid().v1();
    Message message = Message(
      id: msgId,
      toId: uId,
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
    );

    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(message.toJson());

    await  firestore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }
  sendGMessage(String msg, String groupId, {String? type}) async {
    String msgId = const Uuid().v1();
    Message message = Message(
      id: msgId,
      toId: '',
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
    );

    await firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(msgId)
        .set(message.toJson());

    await  firestore.collection('rooms').doc().set({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  Future readMessage(String roomId, String msgId) async {
    firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  Future<void> deleteMsg(String roomId, List<String> msgs) async {
    List<Future<void>> futures = msgs.map((msg) async {
      try {
        await firestore
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(msg)
            .delete();
      } catch (e) {
        // ignore: avoid_print
        print('Failed to delete msg $msg: $e');
        // Handle error (e.g., log it, rethrow it, etc.)
      }
    }).toList();

    await Future.wait(futures);
  }


  Future  editGroup (String name, String groupId,List members) async {
    await firestore
        .collection('groups')
        .doc(groupId)
        .update({'name': name,'members': FieldValue.arrayUnion(members)});
  }

  Future remMember(String groupId, List memberId) async {
    await firestore
        .collection('groups')
        .doc(groupId)
        .update({'members': FieldValue.arrayRemove(memberId)});
  }





// deleteMsg( String roomId, List<String> msgs) async {
//   if (msgs.length ==1) {
//     await firestore
//         .collection('rooms')
//         .doc(roomId)
//         .collection('messages')
//         .doc(msgs.first)
//         .delete();
//   }else{
//     for(var element in msgs){
//       await firestore
//           .collection('rooms')
//           .doc(roomId)
//           .collection('messages')
//           .doc(element)
//           .delete();
//     }
//   }

// }
}
