import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
TextFormField(
  controller: emailController,
  decoration: InputDecoration(
    hintText: 'Email'
  ),
),
            SizedBox(height: 50,),
            RoundButton(title: 'Forgot Password',onTap: (){
auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
  Utils().toastMessage('We have sent a email to reset password please check your registered email');
}).onError((error, stackTrace) {
  Utils().toastMessage(error.toString());
});
            },),
          ],
        ),
      ),
    );
  }
}
