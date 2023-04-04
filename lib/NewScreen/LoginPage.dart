import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:heyou/NewScreen/Otp_Screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String verify = "";
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
final TextEditingController controller = TextEditingController();
bool _isLoading = false;
String numbe = "";

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
                child: Text('REGISTER',
                  style: TextStyle(fontFamily: "Nunito", fontSize: 24, color: Colors.black),),
              ),
              FadeInDown(
                delay: Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                  child: Text('Enter your phone number to continue, we will send you OTP to verifiy.',
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
                      InternationalPhoneNumberInput(

                       textStyle: TextStyle(fontFamily: "Nunito"),
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            numbe = number.phoneNumber.toString();
                          });
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,

                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black,fontFamily: "Nunito"),
                        textFieldController: controller,
                        formatInput: false,
                        maxLength: 11,

                        keyboardType:
                        TextInputType.numberWithOptions(signed: true, decimal: true),
                        cursorColor: Theme.of(context).primaryColor,

                        inputDecoration: InputDecoration(
                          labelStyle: TextStyle(fontFamily: "Nunito"),
                          contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16,fontFamily: "Nunito"),
                        ),
                        onSaved: (PhoneNumber number) {

                        },
                      ),
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      )
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

                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: numbe,
                        verificationCompleted: (PhoneAuthCredential credential){
                        pincontroller.setText(credential.smsCode!);
                        },
                        verificationFailed: (FirebaseAuthException e){},
                        codeSent: (String verificationId, int? resendToken){
                          LoginPage.verify=verificationId;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(number: numbe,)));
                        },
                        codeAutoRetrievalTimeout: (String verificationId){

                        });


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
                  Text("Request OTP", style: TextStyle(color: Colors.white,fontFamily: "Nunito"),),
                ),
              ),
              SizedBox(height: 20,),
              FadeInDown(
                delay: Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Nunito"),),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text('Login', style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "Nunito"),),
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