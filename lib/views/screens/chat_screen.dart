import 'package:chat/views/widgets/chat/messages.dart';
import 'package:chat/views/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final String receiverId;
  final String name;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.receiverId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(chatRoomId: chatRoomId),
          ),
          NewMessage(chatRoomId: chatRoomId, receiverId: receiverId),
        ],
      ),
    );
  }
}
