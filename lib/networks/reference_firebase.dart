import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jo_amman/config/enum/order_status_enum.dart';
import 'package:jo_amman/models/config_model.dart';
import 'package:jo_amman/models/order_model.dart';
import 'package:jo_amman/models/slider_model.dart';
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

  static DocumentReference<UserModel> GET_USER(String id) => FirebaseFirestore.instance.collection('users').doc(id).withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        var model = UserModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static CollectionReference ORDERS = FirebaseFirestore.instance.collection('orders').withConverter<OrderModel>(
      fromFirestore: (snapshot, options) {
        var model = OrderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static Query<OrderModel> GET_ORDERS(OrderStatusEnum status) => FirebaseFirestore.instance.collection('orders').where('status', isEqualTo: status.name).where('is_deleted', isEqualTo: false).withConverter<OrderModel>(
      fromFirestore: (snapshot, options) {
        var model = OrderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static DocumentReference<OrderModel> GET_ORDER(String id) => FirebaseFirestore.instance.collection('orders').doc(id).withConverter<OrderModel>(
      fromFirestore: (snapshot, options) {
        var model = OrderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static CollectionReference SLIDERS = FirebaseFirestore.instance.collection('sliders').withConverter<SliderModel>(
      fromFirestore: (snapshot, options) {
        var model = SliderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static Query<SliderModel> GET_SLIDERS() => FirebaseFirestore.instance.collection('sliders').where('is_deleted', isEqualTo: false).withConverter<SliderModel>(
      fromFirestore: (snapshot, options) {
        var model = SliderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());

  static Query<ConfigModel> GET_CONFIG() => FirebaseFirestore.instance.collection('config').withConverter<ConfigModel>(
      fromFirestore: (snapshot, options) {
        var model = ConfigModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());


  static DocumentReference<OrderModel> CHANGE_CONFIG(String id) => FirebaseFirestore.instance.collection('config').doc(id).withConverter<OrderModel>(
      fromFirestore: (snapshot, options) {
        var model = OrderModel.fromJson(snapshot.data()!);
        model.id = snapshot.id;
        return model;
      },
      toFirestore: (model, options) => model.toJson());



}
