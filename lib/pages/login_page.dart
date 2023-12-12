// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:rcas/Components/TextFields/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
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
                height: 35,
              ),
              MyTextField(
                hint: 'Email',
                controller: emailController,
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                hint: "Password",
                controller: passwordController,
                obsucreText: true,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    print("Sign in");
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
                    onTap: () {
                      print("Registering");
                    },
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
