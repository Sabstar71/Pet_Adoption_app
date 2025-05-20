import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PawPalApp/Chat/message.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Get a stream of all users except the current one
  Stream<List<Map<String, dynamic>>> getUserStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Stream.value([]); // Return empty if not logged in
    }

    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != currentUser.uid)
          .map((doc) => {
                'uid': doc.id,
                'email': doc['email'],
              })
          .toList();
    });
  }

  // ✅ Send a message
  Future<void> sendMessage(String receiverID, String message) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null || message.trim().isEmpty) return;

    final timestamp = Timestamp.now();
    final newMessage = Message(
      senderId: currentUser.uid,
      senderEmail: currentUser.email!,
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

  // ✅ Get message stream between two users
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    final chatRoomId = _generateChatRoomId(userId, otherUserId);
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // ✅ Generate consistent chat room ID
  String _generateChatRoomId(String id1, String id2) {
    final ids = [id1, id2];
    ids.sort(); // Ensures consistency
    return ids.join("_");
  }
}
