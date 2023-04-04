import 'package:flutter/material.dart';
import 'package:heyou/NewScreen/LoginPage.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(

            children: [
              SizedBox(height: 20,),
              Text("Welcome to HeyYou",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 29,fontFamily: "Nunito"),),
              SizedBox(height: MediaQuery.of(context).size.height / 10,),
              Image.asset("assets/bg.png",color: Theme.of(context).primaryColor,height:300 , width: 300,),
              SizedBox(height: MediaQuery.of(context).size.height / 7.5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(

                  style: TextStyle(

                    color:Colors.black,
                    fontSize: 14,
                    fontFamily: "Nunito",

                  ),
                  children: [
                    TextSpan(text: "Agree and Continue to accept the"),
                    TextSpan(text: " HeyYou Terms of Service and Privacy Policy",style: TextStyle(color: Theme.of(context).primaryColor)),

                  ],
                )),
              ),
              SizedBox(height: 10,),
              Container(

                width: MediaQuery.of(context).size.width -110,
                height: 50 ,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> LoginPage()));
                  },
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.all(0),
                    elevation: 8,
                    child: Center(
                      child: Text("AGREE AND CONTINUE",style: TextStyle(color: Colors.white,fontFamily: "Nunito"),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
