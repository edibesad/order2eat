import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order2eat/models/ordered_menu_model.dart';
import 'package:order2eat/models/user_model.dart';

class OrderModel {
  UserModel user;
  List<OrderedMenuModel> orderedMenus;
  String paidType;
  late Timestamp time;

  OrderModel({
    required this.user,
    required this.orderedMenus,
    required this.paidType,
  }) {
    time = Timestamp.now();
  }
}
