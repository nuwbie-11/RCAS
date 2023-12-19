// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcas/Components/TextFields/my_text_field.dart';
import 'package:rcas/controllers/user_controller.dart';
import 'package:rcas/models/user_model.dart';
import 'package:rcas/pages/main_app.dart';

class EditUser extends StatefulWidget {
  final UserModel? user;
  const EditUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.user!.email;
    _firstNameController.text = widget.user!.firstName;
    _lastNameController.text = widget.user!.lastName;
    _ageController.text = widget.user!.age.toString();
  }

  updateUser() async {
    var id = await UserController.findDocId(_emailController.text);
    var model = UserModel(
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        age: int.parse(_ageController.text));
    UserController.updateUser(id, model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              MyTextField(
                hint: 'Email',
                controller: _emailController,
                readOnly: true,
              ),
              SizedBox(
                height: 10,
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
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  updateUser();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainApp()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
