import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcas/models/user_model.dart';

class UserController {
  static final _db = FirebaseFirestore.instance.collection('users');

  static createUser(UserModel model) async {
    await _db.add(model.toMap());
  }

  static Future getUser(String email) async {
    var res = await _db.where('email', isEqualTo: email).get();
    // print(res.docs[0].data());
    // var user = UserModel.fromJson(res.docs[0].data());
    // print(user.age);
    return UserModel.fromJson(res.docs[0].data());
  }
}
