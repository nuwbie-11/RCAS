// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rcas/controllers/car_controller.dart';
import 'package:rcas/models/cars_model.dart';

class CarDetails extends StatefulWidget {
  final CarModel car;
  CarDetails({Key? key, required this.car}) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  void deleteCar() async {
    Reference storageRef =
        FirebaseStorage.instance.refFromURL(widget.car.imgUrl);
    await storageRef.delete();
    var id = await CarController.findCars(widget.car.imgUrl);
    CarController.deleteCar(id);
  }

  void rentCar() async {
    var id = await CarController.findCars(widget.car.imgUrl);
    widget.car.renterMail = FirebaseAuth.instance.currentUser!.email!;
    CarController.updateCar(id, widget.car);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.car.imgUrl),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              color: Colors.red,
              child: Row(
                children: [
                  Container(
                    color: Colors.black,
                    child: FirebaseAuth.instance.currentUser!.email! ==
                            widget.car.ownerMail
                        ? TextButton(
                            onPressed: () {
                              deleteCar();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ))
                        : widget.car.renterMail != ""
                            ? TextButton(
                                onPressed: () {
                                  rentCar();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Rent Car",
                                  style: TextStyle(color: Colors.greenAccent),
                                ))
                            : Text("Rented",
                                style: TextStyle(color: Colors.greenAccent)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
