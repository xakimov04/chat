import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatelessWidget {
  final String chatRoomId;
  final String receiverId;

  NewMessage({
    super.key,
    required this.chatRoomId,
    required this.receiverId,
  });

  final _formKey = GlobalKey<FormState>();
  final _messageTextController = TextEditingController();
  String? _message;

  void _sendmessage() {
    _formKey.currentState!.save();

    if (_message != null && _message!.trim().isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("chats")
          .doc(chatRoomId)
          .collection("messages")
          .add({
        "text": _message,
        'createdAt': Timestamp.now(),
        'userId': user!.uid,
        'receiverId': receiverId
      });
      _messageTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _messageTextController,
                onSaved: (newValue) {
                  _message = newValue;
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Enter message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _sendmessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
