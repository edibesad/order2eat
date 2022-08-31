import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/menu_model.dart';

import '../../../providers/all_providers.dart';

// ignore: must_be_immutable
class MenusFilterDropdown extends ConsumerWidget {
  List<MenuModel> menus;
  MenusFilterDropdown(this.menus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<int>(
      value: ref.watch(dropdowndMenuValueProvider),
      hint: const Text("Choose a menu..."),
      items: [
        DropdownMenuItem(
          value: -1,
          child: const Text("All Menus"),
          onTap: () {
            ref.read(dropdowndMenuValueProvider.state).state = -1;
          },
        ),
        for (var element in menus) createDropDownMenuItem(element),
      ],
      onChanged: (value) {
        for (var element in menus) {
          if (element.id == value) {
            ref.read(dropdowndMenuValueProvider.state).state = element.id!;
            ref.read(filteredMenusProvider.state).state = element.menus!;
            return;
          }
        }
        ref.read(filteredMenusProvider.state).state =
            ref.read(allMenusProvider.state).state;
      },
    );
  }

  DropdownMenuItem<int> createDropDownMenuItem(MenuModel menuModel) {
    return DropdownMenuItem<int>(
      value: menuModel.id,
      child: Text(menuModel.name!),
    );
  }
}
