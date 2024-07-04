import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBbuble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp time;
  const MessageBbuble(
    this.message,
    this.isMe, {
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: isMe
                  ? const Radius.circular(12.0)
                  : const Radius.circular(20.0),
              topRight: isMe
                  ? const Radius.circular(20.0)
                  : const Radius.circular(12),
              bottomLeft:
                  isMe ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(20.0),
            ),
            color: isMe ? Colors.blueGrey.withOpacity(.8) : Colors.deepPurple,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                time.toDate().toString().substring(0, 16),
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
