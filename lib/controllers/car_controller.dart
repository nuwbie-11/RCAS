import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcas/models/cars_model.dart';

class CarController {
  static final _db = FirebaseFirestore.instance.collection('cars');

  static addCars(CarModel model) async {
    await _db.add(model.toMap());
  }

  static Future getCars() async {
    // Map maps = {};
    var snapsots = await _db.get();
    final allData = snapsots.docs.map((doc) => doc.data()).toList();
    return (allData);
    // return CarModel.fromJson(res.docs);
  }
}
