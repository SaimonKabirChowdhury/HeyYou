import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({ required this.message, required this.time, required this.connected});
  final String message;
  final String time;
  final bool connected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(

            children: [
              Padding(

                padding: const EdgeInsets.only(
                  left: 20,
                  right: 45,
                  top: 5,
                  bottom: 28,
                ),
                child: Text(

                  message,
                  style: TextStyle(

                    fontSize: 16,
                    fontFamily: "Nunito"
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Nunito",
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                    connected? Icons.done_all:Icons.done,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}