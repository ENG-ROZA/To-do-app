import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Layout/home_layout.dart';
import 'package:to_do/Screens/SignUp/sign_up.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';
import 'package:to_do/providers/my_provider.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  // <FormState> The Type Of The Templete Parameter "Form" .
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  //Controller purpose is To bring data from text field .
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Login.jpg"),
                fit: BoxFit.cover)),
      ),
      Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('Login',
              style: GoogleFonts.elMessiri(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Hello Dear ",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Icon(Icons.assignment_ind_outlined)
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
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
                    labelStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: _passwordVisible,
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please Enter Valid Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.security,
                      color: Colors.white,
                    ),
                    labelStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: _passwordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunctions.logIn(emailController.text,
                          passwordController.text, context, () {
                        pro.initMyUser();

                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeLayout.routName, (route) => false);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignUp.routeNames, (route) => false);
                      },
                      child: Text(
                        "Create account",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
