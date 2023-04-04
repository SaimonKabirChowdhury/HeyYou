import 'package:flutter/material.dart';
import 'package:heyou/Models/ChatModel.dart';
import 'package:flutter_svg/svg.dart';
import '../Screens/Individualpage.dart';

class CustomCard extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  const CustomCard(this.chatModel, this.sourceChat);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                  chatModel: widget.chatModel,
                  source: widget.sourceChat,
                )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                widget.chatModel.isGroup! ? "assets/groups.svg" : "assets/person.svg",
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
            title: Text(
              widget.chatModel.name!,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Nunito",
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                 widget.chatModel.currentMsg!,
                  style: TextStyle(
                    fontSize: 13,

                  ),
                ),
              ],
            ),
            trailing: Text(widget.chatModel.time!),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}