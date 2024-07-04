import 'package:chat/views/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final String chatRoomId;

  const Messages({super.key, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = streamSnapshot.data!.docs;
        print(docs);
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: MessageBbuble(
                docs[index]['text'],
                docs[index]['userId'] == user!.uid,
                key: ValueKey(docs[index].id),
                time: docs[index]['createdAt'],
              ),
            );
          },
        );
      },
    );
  }
}
