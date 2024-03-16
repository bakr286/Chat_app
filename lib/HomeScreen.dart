import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:packages_reusable/ChatScreen.dart';
String newName = "";
String newMessage = "";


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatData> chats = [];
  final _formKey = GlobalKey<FormState>();
  bool isDarkTheme = false; // Track theme state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading:IconButton(
            icon: Icon(
              isDarkTheme ? Icons.brightness_3 : Icons.wb_sunny,
            ),
            onPressed: () {
              setState(() {
                isDarkTheme = !isDarkTheme;
              });
            },
          ),
          title: const Text('Chats'),
          centerTitle: true,
          backgroundColor: Colors.cyan, // Adjust color for both themes
        ),

      body:
      ListView.separated(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return Chats(
            context: context, // Pass the context here
            name: chats[index].name,
            message: chats[index].message,
            time: chats[index].time,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(height: 5),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {

              final currentTime = DateTime.now(); // Capture the current time
              return AlertDialog(
                title: Text('Add Chat'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null; // Return null if the validation is successful
                        },
                        decoration: InputDecoration(labelText: 'Name'),
                        onChanged: (value) {
                          newName = value;
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the message';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Message'),
                        onChanged: (value) {
                          newMessage = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          chats.add(
                            ChatData(
                              name: newName,
                              message: newMessage,
                              time: currentTime,
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    )
    );
  }
}
class ChatData {
  final String name;
  final String message;
  final DateTime time;

  ChatData({required this.name, required this.message, required this.time});
}

// Pass context as a parameter to Chats widget
Widget Chats({
  required BuildContext context,
  required String name,
  required String message,
  required DateTime time,
}) {
  return InkWell(
    onTap: () {
      newName=name;
      newMessage=message;
      Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
    },
    child: ListTile(
      leading: Text(
        name[0],
        style: TextStyle(fontSize: 30),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text('${time.hour}:${time.minute}'),
    ),
  );
}

