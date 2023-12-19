import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcas/models/cars_model.dart';

class CarController {
  static final _db = FirebaseFirestore.instance.collection('cars');

  static addCars(CarModel model) async {
    await _db.add(model.toMap());
  }

  static Future getCars() async {
    var snapsots = await _db.get();
    final allData = snapsots.docs.map((doc) => doc.data()).toList();

    return List.generate(
        allData.length, (index) => CarModel.fromJson(allData[index]));
  }

  static findCars(String imgUrl) async {
    var res = await _db.where('imgUrl', isEqualTo: imgUrl).get();
    // print(res.docs[0].reference.id);
    return res.docs[0].reference.id;
  }

  static deleteCar(String id) async {
    await _db.doc(id).delete();
  }

  static updateCar(String id, CarModel model) async {
    await _db.doc(id).update(model.toMap());
  }
}
