import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/Login/Login.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';
import 'package:to_do/providers/my_provider.dart';

class SignUp extends StatefulWidget {
  static const String routeNames = 'SignUP';

  @override
  State<SignUp> createState() => _signUpState();
}

class _signUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var ageController = TextEditingController();

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: formKey,
          child: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/images/Login.jpg',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: const Icon(
                            Icons.person_3_outlined,
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        controller: ageController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Please Enter Your Age';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: const Icon(
                            Icons.person_2,
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Please Enter An Email';
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Please Enter a Valid Number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.done,
                        obscureText: passwordVisible,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Please Enter Valid Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: const EdgeInsets.all(8.0),
                          prefixIcon: const Icon(Icons.password_rounded,
                              color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: passwordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          FirebaseFunctions.signUp(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                  int.parse(ageController.text))
                              .then((value) {}) //int.parse(ageController.text);
                              .catchError((e) {
                            print(e);
                          });
                          pro.initMyUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Login.routeName, (route) => false);

                          //.text this is the text in TextFormField .
                        },
                        elevation: 0,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.white,
                        child: const Text(
                          'sign in',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
