// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcas/controllers/car_controller.dart';
import 'package:rcas/controllers/user_controller.dart';
import 'package:rcas/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final user = FirebaseAuth.instance.currentUser!;
  UserModel? activeUser;
  Future<dynamic>? _cars;

  @override
  void initState() {
    super.initState();
    getInfo();
    setState(() {
      _cars = _getCars();
    });
  }

  _getCars() {
    return CarController.getCars();
  }

  Future onRefresh() async {
    setState(() {
      _cars = _getCars();
    });
  }

  void getInfo() {
    UserController.getUser(user.email!).then((value) => setState(() {
          activeUser = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
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
          }
        },
        key: navigationKey,
        color: Colors.deepPurple.shade200,
        backgroundColor: Colors.transparent,
        height: 55,
        items: <Widget>[
          Icon(color: Colors.white, Icons.home),
          Icon(color: Colors.white, Icons.bookmark),
          Icon(color: Colors.white, Icons.exit_to_app),
        ],
      ),
      body: activeUser != null
          ? Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Profile(),
                  Expanded(
                    child: FutureBuilder(
                      future: _cars,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return RefreshIndicator(
                            onRefresh: onRefresh,
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return CarCards(
                                  carName: data[index]['carName'],
                                  imgUrl: data[index]['imgUrl'],
                                );
                              }),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Row Profile() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          child: Icon(
            Icons.person_2_rounded,
            color: Colors.white,
            size: 32,
          ),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(
                99,
              )),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome Back,",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "${activeUser!.firstName} ${activeUser!.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    print("Edit Profile");
                  },
                  child: Icon(
                    Icons.edit,
                    size: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CarCards extends StatelessWidget {
  final String carName;
  final String imgUrl;

  const CarCards({
    super.key,
    required this.carName,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imgUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    carName,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
