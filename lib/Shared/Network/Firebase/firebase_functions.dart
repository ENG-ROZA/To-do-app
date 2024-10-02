import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Models/TaskModel.dart';
import 'package:to_do/Models/userModel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(
            'Tasks') //You should write The Same Name in online Firebase Collection .
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(
            'Users') //You should write The Same Name in online Firebase Collection .
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) async {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    print(DateUtils.dateOnly(date).millisecondsSinceEpoch);
    print('date');
    print(getTaskCollection());

    return getTaskCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('data',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> signUp(
      String email, String password, String name, int age) async {
    //static Let me to call Function with Class Name ;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          Name: name, Age: age, id: credential.user!.uid, Email: email);

      var collection = getUserCollection();
      var docRef = collection.doc(credential.user!.uid);
      docRef.set(userModel);
    } //try << store Code and if Errors Founded We Go To Catch .
    on FirebaseAuthException catch (e) {
      //e present "error" .
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logIn(String email, String password, BuildContext context,
      Function onComplete) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        onComplete();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> editTask(TaskModel task) {
    return getTaskCollection().doc(task.id).update(task.tojson());
  }

  static Future<UserModel?> readUser(String userId) async {
    DocumentSnapshot<UserModel> userdoc =
        await getUserCollection().doc(userId).get();
    return userdoc.data();
  }
}
