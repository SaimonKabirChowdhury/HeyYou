import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  ButtonCard({required this.name,required this.icon});
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        child: Icon(
          icon,
          size: 26,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontFamily: "Nunito",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}