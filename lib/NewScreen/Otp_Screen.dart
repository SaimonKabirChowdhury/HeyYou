import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heyou/NewScreen/LoginPage.dart';
import 'package:heyou/Screens/LoginScreen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  String number;

  OtpScreen({required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
final FirebaseAuth auth = FirebaseAuth.instance;
final TextEditingController controller = TextEditingController();
bool _isLoading = false;
TextEditingController pincontroller = TextEditingController();
var sms;

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("HeyYou",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 29,fontFamily: "Nunito"),),
                SizedBox(height: 50,),
                FadeInDown(
                  child: Text('Verify Number',
                    style: TextStyle(fontFamily: "Nunito", fontSize: 24, color: Colors.black),),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                    child: Text('Enter the OTP to verify this ${widget.number} number',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700,fontFamily: "Nunito"),),
                  ),
                ),
                SizedBox(height: 30,),
                FadeInDown(
                  delay: Duration(milliseconds: 400),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(0.13)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Pinput(


                          submittedPinTheme: PinTheme(textStyle: TextStyle(fontFamily: "Nunito")),
                          androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                          controller: pincontroller,
                          length: 6,
                          pinAnimationType: PinAnimationType.fade,
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onChanged: (value){
                            sms = value;
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                FadeInDown(
                  delay: Duration(milliseconds: 600),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () async{
                      try{
                        PhoneAuthCredential pcred = PhoneAuthProvider.credential(
                            verificationId: LoginPage.verify,
                            smsCode: sms,


                        );
                        
                        await auth.signInWithCredential(pcred);
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (builder)=>LoginScreen()), (route) => false);
                        
                      }catch(e){
                        print(e);
                      }
                   
                    

                      setState(() {
                        _isLoading = true;
                      });

                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          _isLoading = false;
                        });



                      });
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: _isLoading  ? Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ) :
                    Text("Verify", style: TextStyle(color: Colors.white,fontFamily: "Nunito"),),
                  ),
                ),
                SizedBox(height: 20,),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn\'t receive code yet?", style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Nunito"),),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: () async{
                          await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: widget.number,
                              verificationCompleted: (PhoneAuthCredential credential){

                              },
                              verificationFailed: (FirebaseAuthException e){},
                              codeSent: (String verificationId, int? resendToken){

                              },
                              codeAutoRetrievalTimeout: (String verificationId){

                              });
                        },
                        child: Text('Resend OTP', style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Nunito"),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}