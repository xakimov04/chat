import 'package:chat/views/screens/chat_screen.dart';
import 'package:chat/views/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Users",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 1,
      ),
      drawer: const TelegramDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!.docs;
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              final user = users[index];
              return UserListTile(
                user: user,
                onTap: () {
                  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                  final chatRoomId = getChatRoomId(currentUserId, user.id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        name: user['username'],
                        chatRoomId: chatRoomId,
                        receiverId: user.id,
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

  String getChatRoomId(String userId1, String userId2) {
    if (userId1.hashCode <= userId2.hashCode) {
      return '$userId1-$userId2';
    } else {
      return '$userId2-$userId1';
    }
  }
}

class UserListTile extends StatelessWidget {
  final QueryDocumentSnapshot user;
  final VoidCallback onTap;

  const UserListTile({
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blueGrey.shade200,
        child: Center(
          child: Text(
            user['username'][0].toString().toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      title: Text(
        user['username'],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        user['email'],
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
    );
  }
}
