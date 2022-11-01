import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading =  false;
  final databaseRef = FirebaseDatabase.instance.ref('Test');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Posts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
const SizedBox(height: 30,),
            TextFormField(
              validator: (value) {
                return 'Please write something';
              },


              controller: postController,
              maxLines: 4,

              decoration: const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder(),


              ),
            ),
            const SizedBox(height: 30,),
RoundButton(title: 'Add',loading:loading,onTap:(){
  setState(() {
    loading = true;
  });
  Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
  String id = DateTime.now().millisecondsSinceEpoch.toString();
databaseRef.child(id).set({
  'title':postController.text.toString(),
  'id': id
}).then((value) {
  setState(() {
    loading = false;
  });
  Utils().toastMessage('Post Added');
}).onError((error, stackTrace){

  Utils().toastMessage(error.toString());
  setState(() {
    loading = false;

  });

});
} ,)
          ],
        ),
      ),
    );
  }


}
