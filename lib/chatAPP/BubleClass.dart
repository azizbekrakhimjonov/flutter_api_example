import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class Bubble extends StatelessWidget {
  final String text;
  Bubble({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: text,
      color: Color.fromARGB(255, 63, 142, 203),
      tail: false,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class Contact {
  final String name;
  final String lastName;
  final int id;

  Contact({required this.name, required this.lastName, required this.id});
}

class ChatPage extends StatelessWidget {
  final Contact contact;

  ChatPage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${contact.name} ${contact.lastName}'),
      ),
      body: Center(
        child: Text('Chat with ${contact.name} ${contact.lastName}'),
      ),
    );
  }
}
