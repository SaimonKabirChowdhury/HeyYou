import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/ChatModel.dart';
class ContactCard extends StatefulWidget {
  ChatModel contact;
  ContactCard({required this.contact});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset(
                "assets/person.svg",
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            widget.contact.select!
                ? Positioned(
              bottom: 4,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 11,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
      title: Text(
        widget.contact.name!,
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Nunito"
        ),
      ),
      subtitle: Text(
        widget.contact.status!,
        style: TextStyle(
          fontSize: 13,
          fontFamily: "Nunito"
        ),
      ),
    );
  }
}