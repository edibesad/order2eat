import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'menu_model.dart';

class OrderedMenuModel {
  late int id;
  Menus menu;
  int quantity = 1;
  double price;
  double optionPrice = 0;
  List<Map<String, dynamic>> optionsCheckbox = [];
  List<Map<String, dynamic>> optionsRadios = [];
  List<Map<String, dynamic>> optionsDropdown = [];

  static int menuNumber = 0;
  set setQuantity(int quantity) {
    this.quantity = quantity;
  }

  OrderedMenuModel(
      {required this.menu, required this.quantity, required this.price}) {
    id = menuNumber;
    menuNumber++;
  }

  OrderedMenuModel copyWith() {
    return OrderedMenuModel(menu: menu, quantity: quantity + 1, price: price);
  }
}

class OrderedMenusNotifier extends StateNotifier<List<OrderedMenuModel>> {
  OrderedMenusNotifier() : super([]);
  void addMenu(OrderedMenuModel orderedMenuModel) {
    state = [...state, orderedMenuModel];
  }

  void increaseQuantity(int id) {
    state = [
      for (final element in state)
        if (element.id == id) element.copyWith() else element,
    ];
  }

  void deleteMenu(int id) {
    state = [
      for (final element in state)
        if (element.id != id) element,
    ];
  }
}
