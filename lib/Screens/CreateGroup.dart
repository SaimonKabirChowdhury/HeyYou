import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heyou/CustomUi/ButtonCard.dart';
import 'package:heyou/CustomUi/ContactCard.dart';
import 'package:heyou/Models/ChatModel.dart';
import 'package:heyou/Screens/CreateGroup.dart';

import '../CustomUi/AvatarCard.dart';
class CreateGroup extends StatefulWidget {


  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Saimon Kabir", status: "A full stack developer", isGroup: false),
    ChatModel(name: "Fahmida Sultana", status: "Flutter Developer...........",isGroup: false),
    ChatModel(name: "Hasnatun Afrin", status: "Web developer...",isGroup: false),
    ChatModel(name: "Taslima Akter", status: "App developer....",isGroup: false),
    ChatModel(name: "Maahi Neo H", status: "Raect developer..",isGroup: false),
    ChatModel(name: "Ashmit Dey", status: "Full Stack Web",isGroup: false),
    ChatModel(name: "Nicholas Tesla", status: "Example work",isGroup: false),
    ChatModel(name: "Elon Musk", status: "Sharing is caring",isGroup: false),
    ChatModel(name: "Saimon Kabir", status: "A full stack developer"),
    ChatModel(name: "Fahmida Sultana", status: "Flutter Developer..........."),
    ChatModel(name: "Hasnatun Afrin", status: "Web developer..."),
    ChatModel(name: "Taslima Akter", status: "App developer...."),
    ChatModel(name: "Maahi Neo H", status: "Raect developer.."),
    ChatModel(name: "Ashmit Dey", status: "Full Stack Web"),
    ChatModel(name: "Nicholas Tesla", status: "Example work"),
    ChatModel(name: "Elon Musk", status: "Sharing is caring"),
  ];
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: "Nunito",
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                    fontFamily: "Nunito"
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {},
            child: Icon(Icons.arrow_forward,color: Colors.white,)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Align(
              child: Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true)
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  groupmember.remove(contacts[index]);
                                  contacts[index].select = false;
                                });
                              },
                              child: AvatarCard(
                                chatModel: contacts[index],
                              ),
                            );
                          return Container();
                        }),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
            )
                : Container(),
          ],
        ));
  }
}