import 'package:flutter/material.dart';

import '../CustomUi/CustomCard.dart';
import '../Models/ChatModel.dart';
import '../Screens/SelectContact.dart';

class ChatPage extends StatefulWidget {

   ChatPage({Key? key, required this.list, required this.source}) : super(key: key);
  final List<ChatModel> list;
  final ChatModel source;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),

      ),
      body: ListView.builder(
        itemCount: widget.list.length,
          itemBuilder: (context,index){
        return CustomCard(widget.list[index],widget.source);
      }),
    );
  }
}
