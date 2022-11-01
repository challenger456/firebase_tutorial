import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/ui/auth/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:firebase_tutorial/utils/utils.dart';

import '../../widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
children: [
  SizedBox(height: 120,),
  TextFormField(
    keyboardType: TextInputType.phone,
    controller: phoneNumberController,
    decoration: InputDecoration(
        hintText: '+1 234 5689 457'
    ),
  ),
  SizedBox(height: 80,),
RoundButton( title: 'Login',loading: loading,
  onTap:(){
  setState(() {
    loading = true;
  });
auth.verifyPhoneNumber(
  phoneNumber: phoneNumberController.text,
    verificationCompleted: (_){
      setState(() {
        loading = false;
      });

    },
    verificationFailed: (e){
      setState(() {
        loading = false;
      });
    Utils().toastMessage(e.toString());
    },
    codeSent: (String verificationId , int? token){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => VerifyCodeScreen(verificationId: verificationId),));
    setState(() {
      loading = false;
    });
    },
    codeAutoRetrievalTimeout: (e){
      setState(() {
        loading = false;
      });
    Utils().toastMessage(e.toString());
    }
);
} ,)
],
        ),
      ),
    );
  }
}


/* command for sha certification for firebase
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android


*/
