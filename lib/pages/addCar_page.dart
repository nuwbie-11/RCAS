// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rcas/Components/TextFields/my_text_field.dart';
import 'package:rcas/controllers/car_controller.dart';
import 'package:rcas/models/cars_model.dart';
import 'package:rcas/pages/home_screen.dart';
import 'package:rcas/pages/main_app.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final ImagePicker _picker = ImagePicker();
  XFile? imgFile;
  final ownerMail = FirebaseAuth.instance.currentUser!.email!;

  TextEditingController carNameController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  ImageSource source = ImageSource.camera;

  @override
  void dispose() {
    carNameController.dispose();
    manufacturerController.dispose();
    yearController.dispose();
    super.dispose();
  }

  imagePicker() async {
    final XFile? img = await _picker.pickImage(source: source);
    if (img != null) {
      setState(() {
        imgFile = img;
      });
    }
  }

  uploadImage() async {
    String uploadFileName = DateTime.now().millisecondsSinceEpoch.toString() +
        "${carNameController.text}.jpg";
    Reference storageRef =
        FirebaseStorage.instance.ref().child('images').child(uploadFileName);
    UploadTask upTask = storageRef.putFile(
      File(imgFile!.path),
      SettableMetadata(
        contentType: 'image/jpeg',
      ),
    );

    await upTask.whenComplete(() async {
      var uploadPath = await upTask.snapshot.ref.getDownloadURL();
      CarModel model = CarModel(
        carName: carNameController.text,
        ownerMail: ownerMail,
        year: int.parse(yearController.text),
        renterMail: "",
        imgUrl: uploadPath,
      );

      CarController.addCars(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Your Car",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                child: InkWell(
                  onTap: imagePicker,
                  child: Ink(
                    child: Center(
                      child: imgFile == null
                          ? Icon(
                              Icons.image,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    height: 256,
                    width: 256,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        image: imgFile != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    FileImage(File(imgFile!.path.toString())),
                              )
                            : null),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                hint: "Car Name",
                controller: carNameController,
                formatted: false,
              ),
              SizedBox(height: 10),
              MyTextField(
                  hint: "Manufacturer",
                  controller: manufacturerController,
                  formatted: false),
              SizedBox(height: 10),
              MyTextField(
                hint: "Year",
                controller: yearController,
                keyboard: TextInputType.number,
                formatted: false,
              ),
              ElevatedButton(
                onPressed: () {
                  uploadImage();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainApp()));
                },
                child: Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
