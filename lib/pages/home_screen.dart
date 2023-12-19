// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcas/Components/car_cards.dart';
import 'package:rcas/controllers/car_controller.dart';
import 'package:rcas/controllers/user_controller.dart';
import 'package:rcas/models/user_model.dart';
import 'package:rcas/pages/edit_user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? activeUser;
  Future<dynamic>? _cars;

  @override
  void initState() {
    super.initState();
    getInfo();
    _cars = _getCars();
  }

  void getInfo() {
    UserController.getUser(FirebaseAuth.instance.currentUser!.email!)
        .then((value) => setState(() {
              activeUser = value;
            }));
  }

  _getCars() {
    return CarController.getCars();
  }

  Future onRefresh() async {
    getInfo();
    setState(() {
      _cars = _getCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      child: activeUser != null
          ? Column(
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
                                car: data[index],
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUser(
                                  user: activeUser!,
                                )));
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
