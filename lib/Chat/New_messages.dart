import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class ChatMessages extends StatelessWidget {
  @override
  Widget build(context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy(
            'CreateAt',
          )
          .snapshots(),
      builder: (context, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(child: Text("NO contact found "));
        }
        final loadedMessages = chatSnapshots.data!.docs;
        return ListView.builder(
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {
              Text(loadedMessages[index].data()['text']);
            });
      },
    );
  }
}
