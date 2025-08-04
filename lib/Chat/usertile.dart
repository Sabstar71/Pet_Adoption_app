import 'package:flutter/material.dart';
import 'package:PawPalApp/Chat/chat.dart';
import 'package:PawPalApp/Chat/chat_services.dart';
import 'package:PawPalApp/theme_provider.dart';

class UserListPage extends StatelessWidget {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: ThemeProvider.headingStyle.copyWith(color: ThemeProvider.lightTextColor, fontSize: 20)),
        centerTitle: true,
        backgroundColor: ThemeProvider.primaryAmber,
        elevation: 2,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: ThemeProvider.primaryAmber));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found", style: ThemeProvider.bodyStyle));
          }
          final users = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: ThemeProvider.lightTextColor.withOpacity(0.2)),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final username = user['username'] ?? 'No Username';
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: ThemeProvider.primaryAmber,
                  child: Text(
                    username.isNotEmpty ? username[0].toUpperCase() : 'U',
                    style: TextStyle(color: ThemeProvider.lightTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(username,
                    style: ThemeProvider.subheadingStyle.copyWith(fontSize: 16)),
                subtitle: Text(user['email'] ?? '', style: ThemeProvider.smallStyle),
                trailing: Icon(Icons.chat, color: ThemeProvider.primaryAmber),
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
