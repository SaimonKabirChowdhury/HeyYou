import 'package:flutter/material.dart';
import 'package:heyou/Models/ChatModel.dart';
import 'package:heyou/Pages/CameraPage.dart';
import 'package:heyou/Pages/StatusPage.dart';
import 'package:heyou/Screens/CallPage.dart';

import '../Pages/ChatOage.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({required this.list,required this.sourcechat});
final List<ChatModel> list;
final ChatModel sourcechat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late TabController controllertab;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    controllertab =  TabController(length: 4, vsync: this,initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("HeyYou",style: TextStyle(fontSize: 20),),
        titleTextStyle: const TextStyle(fontFamily: "Nunito",color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>CamerPage()));
          }, icon: Icon(Icons.camera_alt,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,)),
          PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("New group",style: TextStyle(fontFamily: "Nunito"),),
                    value: "New group",
                  ),
                  PopupMenuItem(
                    child: Text("New broadcast",style: TextStyle(fontFamily: "Nunito")),
                    value: "New broadcast",
                  ),
                  PopupMenuItem(
                    child: Text("Whatsapp Web",style: TextStyle(fontFamily: "Nunito")),
                    value: "Whatsapp Web",
                  ),
                  PopupMenuItem(
                    child: Text("Starred messages",style: TextStyle(fontFamily: "Nunito")),
                    value: "Starred messages",
                  ),
                  PopupMenuItem(
                    child: Text("Settings",style: TextStyle(fontFamily: "Nunito")),
                    value: "Settings",
                  ),
                ];
              }),
        ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: controllertab,
        labelColor: Colors.white,
        labelStyle: TextStyle(fontFamily: "Nunito",color: Colors.white),
        tabs: const[

          Tab(
            icon: Icon(Icons.groups),
          ),
          Tab(
            text: "CHATS",
          ),
          Tab(
            text: "STATUS",
          ),
          Tab(
            text: "CALLS",
          )
        ],
      ),
      ),

      body: TabBarView(

        controller: controllertab,

        children:  [
          Text("Group"),
          ChatPage(list: widget.list,source: widget.sourcechat),
         StatusPage(),
          CallPage(),
        ],
      ),
    );
  }
}
