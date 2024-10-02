import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/Models/userModel.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  MyProvider() {
    FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }
  initMyUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
