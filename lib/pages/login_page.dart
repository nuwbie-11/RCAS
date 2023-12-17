// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:rcas/Components/TextFields/my_text_field.dart';
import 'package:rcas/pages/reset_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "get your preffered car immediately",
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
                isPassword: true,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResetPasswordPage();
                      }));
                    },
                    child: Text(
                      "Forgor Password ?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    signIn();
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
                          "Sign In",
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
                  Text("Not A Member ? "),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
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
