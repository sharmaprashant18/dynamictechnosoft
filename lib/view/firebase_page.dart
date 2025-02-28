import 'package:dynamictechnosoft/model/firebase_model.dart';
import 'package:dynamictechnosoft/services/firebase_services.dart';
import 'package:flutter/material.dart';

class FirebasePage extends StatefulWidget {
  FirebasePage({super.key});
  @override
  State<FirebasePage> createState() => _FirebasePageState();
}
class _FirebasePageState extends State<FirebasePage> {
  final firebaseServices = FirebaseServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    firebaseServices.createNewCollectionBYDocumentID(
                        'user',
                        'collectionID',
                        User(age: 20, email: 'sd,mf@gmail.com', name: 'name'));
                  },
                  child: Text('Firebase By Document ID')),
              TextButton(
                  onPressed: () {
                    firebaseServices.createNewCollection('user',
                        User(age: 20, email: 'sd,mf@gmail.com', name: 'name'));
                  },
                  child: Text('Firebase')),
              TextButton(
                  onPressed: () {
                    firebaseServices.updateCollection('user', 'collectionID',
                        User(age: 20, email: 'sd,mf@gmail.com', name: 'name'));
                  },
                  child: Text('Update Firebase')),
              TextButton(
                  onPressed: () {
                    firebaseServices.deleteSpecificCollection();
                  },
                  child: Text('Delete Specific Firebase')),
              TextButton(
                  onPressed: () {
                    firebaseServices.deleteCollection();
                  },
                  child: Text(
                    'Delete Firebase',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
