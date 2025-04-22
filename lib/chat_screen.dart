import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Center(
        child: Text(
          "Chat with Shelters & Owners",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
