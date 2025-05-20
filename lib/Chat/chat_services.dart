import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PawPalApp/Chat/message.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Stream.value([]);
    }

    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.where((doc) => doc.id != currentUser.uid).map((doc) {
        final data = doc.data();
        return {
          'uid': doc.id,
          'email': data['email'] ?? '',
          'username': data['username'] ?? 'No username',
        };
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final timestamp = Timestamp.now();
    final newMessage = Message(
      senderId: currentUser.uid,
      senderEmail: currentUser.email ?? '',
      receiverId: receiverID,
      message: message,
      timestamp: timestamp,
    );

    final chatRoomId = _generateChatRoomId(currentUser.uid, receiverID);

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    final chatRoomId = _generateChatRoomId(userId, otherUserId);
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  String _generateChatRoomId(String id1, String id2) {
    final ids = [id1, id2];
    ids.sort();
    return ids.join("_");
  }
}
