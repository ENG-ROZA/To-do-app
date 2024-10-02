import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Layout/home_layout.dart';
import 'package:to_do/Screens/Login/Login.dart';
import 'package:to_do/Screens/SignUp/sign_up.dart';
import 'package:to_do/Screens/Tasks/TaskScreen.dart';
import 'package:to_do/Screens/Tasks/task_details.dart';
import 'package:to_do/Screens/edit_tasks.dart';
import 'package:to_do/providers/my_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          provider.firebaseUser != null ? HomeLayout.routName : Login.routeName,
      routes: {
        HomeLayout.routName: (context) => HomeLayout(),
        Login.routeName: (context) => Login(),
        SignUp.routeNames: (context) => SignUp(),
        EditScreen.routeName: (context) => EditScreen(),
        TaskDetails.routeName: (context) => TaskDetails(),
        TaskScreen.routeName : (context)=> TaskScreen(),
      },
      title: 'To Do',
    );
  }
}
