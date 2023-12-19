import 'package:flutter/material.dart';
import 'package:rcas/controllers/car_controller.dart';
import 'package:rcas/models/cars_model.dart';
import 'package:rcas/pages/car_details.dart';

class CarCards extends StatelessWidget {
  final CarModel car;

  const CarCards({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            // CarController.findCars(car.imgUrl);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CarDetails(car: car);
            }));
          },
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(car.imgUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    car.carName,
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
