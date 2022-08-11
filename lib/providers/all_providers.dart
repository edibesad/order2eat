import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/user_model.dart';
import 'package:order2eat/pages/cash_register_page.dart';

import '../models/menu_model.dart';
import '../models/ordered_menu_model.dart';

final orderedMenusNotifier =
    StateNotifierProvider<OrderedMenusNotifier, List<OrderedMenuModel>>((ref) {
  return OrderedMenusNotifier();
});

// final orderedMenusProvider = StateProvider<List<Menus>>(
//   (ref) {
//     return [];
//   },
// );

final menuSearchTextProvider = StateProvider<String>(((ref) => ""));

final allMenusProvider = StateProvider<List<Menus>>(((ref) => []));

final allMenuModelsProvider = StateProvider<List<MenuModel>>(((ref) => []));

final filteredMenusProvider = StateProvider<List<Menus>>(((ref) => []));

final dropdowndMenuValueProvider = StateProvider<int>(((ref) => -1));

final userProvider = StateProvider<UserModel>(((ref) => UserModel()));

final loginFormCheckBoxProvider = StateProvider<bool>(((ref) => false));

final menuToOrderProvider = StateProvider<OrderedMenuModel?>(((ref) => null));

final openedPageProvider = StateProvider<Widget>(
  (ref) => const CashRegisterPage(),
);
