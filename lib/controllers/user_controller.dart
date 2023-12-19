import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcas/models/user_model.dart';

class UserController {
  static final _db = FirebaseFirestore.instance.collection('users');

  static createUser(UserModel model) async {
    await _db.add(model.toMap());
  }

  static Future getUser(String email) async {
    var res = await _db.where('email', isEqualTo: email).get();
    return UserModel.fromJson(res.docs[0].data());
  }

  static Future findDocId(String email) async {
    var res = await _db.where('email', isEqualTo: email).get();
    return res.docs[0].reference.id;
  }

  static Future updateUser(String id, UserModel user) async {
    await _db.doc(id).update(user.toMap());
  }
}
