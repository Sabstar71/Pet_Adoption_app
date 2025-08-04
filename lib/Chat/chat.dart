import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PawPalApp/Chat/chat_services.dart';
import 'package:PawPalApp/theme_provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receiverEmail;

  ChatPage({required this.receiverID, required this.receiverEmail});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverEmail,
          style: ThemeProvider.headingStyle.copyWith(color: ThemeProvider.lightTextColor, fontSize: 20),
        ),
        backgroundColor: ThemeProvider.primaryAmber,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Show user info or settings
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _chatService.getMessages(currentUserID, widget.receiverID),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(color: ThemeProvider.primaryAmber));
                }
                final messages = snapshot.data!.docs;
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 60,
                          color: ThemeProvider.lightTextColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No messages yet",
                          style: ThemeProvider.bodyStyle.copyWith(
                            color: ThemeProvider.lightTextColor.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Start the conversation!",
                          style: ThemeProvider.smallStyle.copyWith(
                            color: ThemeProvider.lightTextColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToBottom());

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index].data() as Map<String, dynamic>;
                    final isMe = data['senderId'] == currentUserID;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isMe ? ThemeProvider.primaryAmber.withOpacity(0.9) : ThemeProvider.lightCardColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft:
                                isMe ? Radius.circular(16) : Radius.circular(0),
                            bottomRight:
                                isMe ? Radius.circular(0) : Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeProvider.shadowColor.withOpacity(0.12),
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          data['message'] ?? '',
                          style: TextStyle(
                              color: isMe ? ThemeProvider.lightTextColor : ThemeProvider.lightTextColor.withOpacity(0.87),
                              fontSize: 16),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: ThemeProvider.smallStyle.copyWith(
                          color: ThemeProvider.lightTextColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: ThemeProvider.disabledColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: ThemeProvider.disabledColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Material(
                    color: ThemeProvider.primaryAmber,
                    borderRadius: BorderRadius.circular(30),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: _sendMessage,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send, color: ThemeProvider.lightTextColor, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
