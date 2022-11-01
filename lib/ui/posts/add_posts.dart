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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Test');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Posts'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: postController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please write something';
                  }else{
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                    if(formkey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(),
                          ));
                      String id = DateTime.now().millisecondsSinceEpoch.toString();
                      databaseRef.child(id).set({
                        'title': postController.text.toString(),
                        'id': id
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage('Post Added');
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    }

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
