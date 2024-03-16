import 'package:flutter/material.dart';
import 'package:packages_reusable/HomeScreen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [newMessage];
  bool isUser = true;
  final time = DateTime.now();

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue,
        title: Text(newName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                if (isUser && index % 2 == 0 || !isUser && index % 2 != 0) {
                  // Blue bubble for user messages on even turns or non-user messages on odd turns
                  return GreenBubble(message: messages[index]);
                } else {
                  // Green bubble for non-user messages on even turns or user messages on odd turns
                  return BlueBubble(message: messages[index]);
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 3), // Adjust spacing between bubbles
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    hintText: 'Type your message...',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GreenBubble extends StatelessWidget {
  final String message;

  GreenBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3), // Adjust vertical spacing
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class BlueBubble extends StatelessWidget {
  final String message;

  BlueBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3), // Adjust vertical spacing
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
