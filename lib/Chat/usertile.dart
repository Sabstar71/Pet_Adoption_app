import 'package:flutter/material.dart';
import 'package:PawPalApp/Chat/chat.dart';
import 'package:PawPalApp/Chat/chat_services.dart';

class UserListPage extends StatelessWidget {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 245, 150, 18),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found"));
          }
          final users = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final username = user['username'] ?? 'No Username';
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    username.isNotEmpty ? username[0].toUpperCase() : 'U',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(username,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(user['email'] ?? ''),
                trailing: Icon(Icons.chat, color: Colors.teal),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        receiverID: user['uid'],
                        receiverEmail: user['email'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
