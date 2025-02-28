import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamictechnosoft/model/firebase_model.dart';

class FirebaseServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  createNewCollection(String collectionName, User userdata) async {
    try {
      await _firestore.collection(collectionName).add(userdata.toJson());
    } catch (e) {
      throw Exception('Error creat new collection:$e');
    }
  }

 void createNewCollectionBYDocumentID(
      String collectionName, String documentdID, User userdata) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(documentdID)
          .set(userdata.toJson());
    } catch (e) {
      throw Exception('Error adding new collection:$e');
    }
  }

 void updateCollection(
      String collectionName, String documentdID, User userdata) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(documentdID)
          .update({'name': "Hari"});
    } catch (e) {
      throw Exception('Error adding new collection:$e');
    }
  }

 void deleteSpecificCollection() async {
    try {
      await _firestore.collection('user').doc('collectionID').update({
        'name': FieldValue.delete(),
      });
    } catch (e) {
      throw Exception('Error adding new collection:$e');
    }
  }

 void deleteCollection() async {
    try {
      await _firestore.collection('user').doc('collectionID').delete();
    } catch (e) {
      throw Exception('Error adding new collection:$e');
    }
  }
}