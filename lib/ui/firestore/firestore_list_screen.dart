import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../auth/login_screen.dart';
import '../posts/add_posts.dart';
import 'add_firstore_data.dart';



class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                icon: const Icon(Icons.logout_rounded)),
            SizedBox(
              width: 10,
            )
          ],
          title: Text('Firestore'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
StreamBuilder<QuerySnapshot>(
  stream: fireStore,
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting)
      return CircularProgressIndicator();

    if(snapshot.hasError)
      return Text('Some Error Occured');

      return Expanded(
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return  ListTile(
onTap: (){
  ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
    'title': 'vipul paliwal'
  }).then((value) {
    Utils().toastMessage('Post Updated');
  }).onError((error, stackTrace) {
    Utils().toastMessage(error.toString());
  });
},
                  title: Text(snapshot.data!.docs[index]['title'].toString()),
                  subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                );
              }

          )
      );
    }),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFireStoreDataScreen(),
                ));
          },
          child: const Icon(Icons.add),
        ));
  }
  Future<void> showMyDialog(String title, String id)async{
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update'),
          content:  Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                  hintText:'Edit'
              ),

            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel'),),
            TextButton(
              onPressed: (){
        Navigator.pop(context);
        },
              child: const Text('Update'),)
          ],
        );
      },




    );
  }
}
