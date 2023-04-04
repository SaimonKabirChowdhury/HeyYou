import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,

            child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: (){},
              child: Icon(Icons.edit,color: Colors.white,),



            ),
          ),
          SizedBox(height: 13,),

          FloatingActionButton(onPressed: (){},
            elevation: 5,
            
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.camera_alt,color: Colors.white,),


          ),
        ],
      ),
    );
  }
}
