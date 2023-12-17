// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:rcas/Components/TextFields/my_text_field.dart';
import 'package:rcas/controllers/user_controller.dart';
import 'package:rcas/models/user_model.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future addUser() async {
    var model = UserModel(
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        age: int.parse(_ageController.text));
    UserController.createUser(model);
  }

  void signUp() async {
    if ((_emailController.text.isNotEmpty) &&
        (_passwordController.text.isNotEmpty) &&
        (validatePassword())) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      addUser();
    }
  }

  bool validatePassword() {
    if (_confirmPasswordController.text == _passwordController.text) {
      return true;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password Does not Match"),
          );
        });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.475,
                  child: Stack(
                    children: [
                      _circleShape(
                          height: 200,
                          width: 200,
                          color: Colors.blueAccent,
                          left: 15),
                      _circleShape(
                          height: 200,
                          width: 200,
                          color: Colors.pinkAccent,
                          right: 15),
                      _circleShape(
                          height: 200,
                          width: 200,
                          color: Colors.deepPurple,
                          top: 90,
                          left: 75),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200]?.withOpacity(0.6)),
                            child: Center(
                              child: Lottie.network(
                                "https://lottie.host/2fd1b458-b272-4d2f-b693-9c19de0198a8/I22JqreJpn.json",
                                repeat: false,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Welcome to ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "DriveHub",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: <Color>[
                                    Colors.blueAccent,
                                    Colors.deepPurple,
                                    Colors.pinkAccent,
                                    //add more color here.
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                ),
                            ),
                          )
                              .animate()
                              .shimmer(duration: 1800.ms, delay: 400.ms)
                              .shake(hz: 4, curve: Curves.easeInOut),
                        ],
                      ),
                      Text(
                        "join us to find your preffered stead !",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hint: "First Name",
                  controller: _firstNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hint: "Last Name",
                  controller: _lastNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hint: "Age",
                  controller: _ageController,
                  keyboard: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hint: 'Email',
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hint: "Password",
                  controller: _passwordController,
                  obsucreText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hint: "Confirm Password",
                  controller: _confirmPasswordController,
                  obsucreText: true,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Member ? "),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        "Login now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_circleShape(
    {double? top,
    double? left,
    double? bottom,
    double? right,
    required double height,
    required double width,
    required Color color}) {
  return Positioned(
    top: top,
    left: left,
    bottom: bottom,
    right: right,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(double.infinity),
          shape: BoxShape.circle,
          color: color),
    ),
  );
}
