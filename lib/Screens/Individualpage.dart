import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heyou/CustomUi/OwnMessageCard.dart';
import 'package:heyou/CustomUi/ReplyMessageCard.dart';
import 'package:heyou/Models/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../Models/MessageModel.dart';
class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel source;
  const IndividualPage({ required this.chatModel, required this.source});

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  io.Socket socket = io.io("http://192.168.0.197:6969",<String,dynamic>{
    "transports" : ["websocket"],
    "autoConnect": "false",

  });
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  bool sendButton = false;
  bool online = true;
  ScrollController scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    connect();
    // TODO: implement initState
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }
  
  void connect(){

   socket.connect();
   socket.onConnect((data) {

     print("Connected");
   socket.on("message", (msg) {
     print(msg["message"]);
     setMessage("destination", msg["message"]);
     scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve:Curves.easeOut );

   });

   });
   socket.emit("SigIn",widget.source.id);


  }
  void sendMsg  (String message,int? sourceId, int? targetid) {
    setMessage("source", message);
    socket.emit("message",{"message":message,"sourceId":sourceId,"targetId":targetid});

  }

  void setMessage(String type, String message){

    setState(() {
      messages.add(MessageModel(type: type, message: message, socket: socket,time:DateTime.now().toString().substring(10,16)));
    });

  }

  @override
  Widget build(BuildContext context) {

    return Stack(


      children: [
        Image.asset("assets/whatsapp.png",height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),

        Scaffold(
          backgroundColor: Colors.teal,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
             titleSpacing: 0,
              backgroundColor: Theme.of(context).primaryColor,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               InkWell(
                 onTap: (){
                   Navigator.pop(context);
                 },
                   child: Icon(Icons.arrow_back,size: 24,)),

                  CircleAvatar(

                    radius: 20,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup! ? "assets/groups.svg" : "assets/person.svg",
                      color: Colors.white,
                      height: 36,
                      width: 36,

                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
              title: InkWell(
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.chatModel.name!,style: TextStyle(fontFamily: "Nunito",fontSize: 18.5),),
                      Text("Last seen at 12:05",style: TextStyle(fontFamily: "Nunito",fontSize: 12),),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.videocam,color: Colors.white,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.white,)),

                PopupMenuButton<String>(
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext contesxt) {
                      return [
                        PopupMenuItem(
                          child: Text("View Contact",style: TextStyle(fontFamily: "Nunito"),),
                          value: "View Contact",
                        ),
                        PopupMenuItem(
                          child: Text("Media, links and docs",style: TextStyle(fontFamily: "Nunito")),
                          value: "Media",
                        ),
                        PopupMenuItem(
                          child: Text("Whatsapp Web",style: TextStyle(fontFamily: "Nunito")),
                          value: "Whatsapp Web",
                        ),
                        PopupMenuItem(
                          child: Text("Search",style: TextStyle(fontFamily: "Nunito")),
                          value: "Search",
                        ),
                        PopupMenuItem(
                          child: Text("Mute Notification",style: TextStyle(fontFamily: "Nunito")),
                          value: "Mute",
                        ),
                        PopupMenuItem(
                          child: Text("Wallpaper",style: TextStyle(fontFamily: "Nunito")),
                          value: "Wallpaper",
                        ),
                      ];
                    }),
              ],

            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(

              child: Column(
                children: [
                  Expanded(
                     // height: MediaQuery.of(context).size.height -140,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount:messages.length+1,itemBuilder: (context,index){
                            if(index == messages.length){
                              return Container(
                                height: 70,
                              );
                            }
                        if(messages[index].type=="source"){
                          print("messages:${messages[index].message}");
                          return OwnMessageCard(message:messages[index].message??"No message",time: messages[index].time??"",connected: online,);
                        }else {
                          print("messages:${messages[index].message}");
                          return ReplyCard(message:messages[index].message??'No message',time: messages[index].time??"",);
                        }
                      })),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width-60,
                                child: Card(

                                  margin: EdgeInsets.only(left: 2,right: 2,bottom: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    style: TextStyle(fontFamily: "Nunito"),
                                    focusNode: focusNode,
                                    controller: controller,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value){
                                      if(value.length >0){
                                        setState(() {
                                          sendButton = true;
                                        });
                                      }else{
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      prefixIcon:IconButton(onPressed: (){
                                        setState(() {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          show = !show;
                                        });
                                      },icon: Icon(Icons.emoji_emotions_outlined,color: Theme.of(context).primaryColor,),),
                                      hintText: "Type a message",
                                      contentPadding: EdgeInsets.all(5),
                                      hintStyle: TextStyle(fontFamily: "Nunito"),
                                      suffixIcon: Row(
                                         mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(onPressed: (){
                                            showModalBottomSheet(
                                                backgroundColor:
                                                Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet());
                                          }, icon: Icon(Icons.attach_file,color: Theme.of(context).primaryColor,)),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,color: Theme.of(context).primaryColor,))
                                        ],
                                      ),
                                    ),
                                  ),),
                              ),
                             Padding(
                               padding: const EdgeInsets.only(bottom: 8.0,right: 5,left: 2),
                               child: CircleAvatar(

                                 child: IconButton(
                                   onPressed: (){

                                     if(sendButton){
                                       scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve:Curves.easeOut );
                                       sendMsg(controller.text, widget.source.id, widget.chatModel.id);
                                       controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                     }

                                   },
                                   icon: Icon(
                                     sendButton?  Icons.send : Icons.mic),
                                   color: Colors.white,

                                 ),
                               ),
                             ),
                            ],
                          ),
                          show?emojiSelect():Container(),
                        ],
                      ),
                    ),

                  ),
                ],
              ),
              onWillPop: (){
                if(show){
                  setState(() {
                    show = false;
                  });
                }else{
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget bottomSheet(){
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Theme.of(context).primaryColor, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Theme.of(context).primaryColor, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Theme.of(context).primaryColor, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Theme.of(context).primaryColor, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Theme.of(context).primaryColor, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Theme.of(context).primaryColor, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Nunito"
            ),
          )
        ],
      ),
    );
  }
  Widget emojiSelect(){

    return EmojiPicker2(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji,category){
          setState(() {
            controller.text = controller.text+emoji.emoji ;
          });
        });
  }
}
