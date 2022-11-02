import 'package:apiinterview/views/other/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithPhone extends StatefulWidget {

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

  TextEditingController phoneController = TextEditingController(text: "+91 9638698904");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple)
              ),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone number"),
                keyboardType: TextInputType.phone,
              ),
            ),
            Visibility(child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple)
            ),
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(),
                keyboardType: TextInputType.number,
              ),
            ),
              visible: otpVisibility,),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if(otpVisibility){
                    verifyOTP();
                  }
                  else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }
  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }
  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>HomePage())
      );
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
}