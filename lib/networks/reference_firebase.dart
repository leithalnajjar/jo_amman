import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jo_amman/models/user_model.dart';

class ReferenceFirebase {
  static CollectionReference USERS = FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        var model = UserModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static Query<UserModel> GET_USERS(String phoneNumber) => FirebaseFirestore.instance.collection('users').where('phone_number', isEqualTo: phoneNumber).where('is_deleted', isEqualTo: false).withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        var model = UserModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());
}