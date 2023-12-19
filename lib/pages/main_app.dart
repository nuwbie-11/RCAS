// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcas/pages/addCar_page.dart';
import 'package:rcas/pages/home_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int _index = 0;
  List screen = [
    HomeScreen(),
    AddCarPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        onTap: (ix) {
          if (ix == 2) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Are You sure wanted to log out?"),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  // _updateTask();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.amber),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                }).then((value) {
              final navigationState = navigationKey.currentState!;
              navigationState.setPage(0);
            });
          } else {
            setState(() {
              _index = ix;
            });
          }
        },
        key: navigationKey,
        color: Colors.deepPurple.shade200,
        backgroundColor: Colors.transparent,
        height: 55,
        items: <Widget>[
          Icon(color: Colors.white, Icons.home),
          Icon(color: Colors.white, Icons.add),
          Icon(color: Colors.white, Icons.exit_to_app),
        ],
      ),
      body: screen[_index],
    );
  }
}
