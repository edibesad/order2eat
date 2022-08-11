import 'package:flutter/material.dart';
import 'package:order2eat/models/menu_model.dart';
import 'package:order2eat/widgets/menus/filter/menus_filter_dropdown.dart';
import 'package:order2eat/widgets/menus/filter/menus_filter_text_field.dart';
import 'package:sized_context/sized_context.dart';

// ignore: must_be_immutable
class MenusFilterField extends StatelessWidget {
  List<MenuModel> menus;
  MenusFilterField(this.menus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Flexible(
              flex: 6,
              child: MenusFilterTextField(),
            ),
            context.diagonalInches >= 10
                ? MenusFilterDropdown(menus)
                : Container()
          ],
        ),
        context.diagonalInches < 10 ? MenusFilterDropdown(menus) : Container()
      ],
    );
  }

  getAllMenus(List<MenuModel> menus) {
    List<Menus> allMenus = [];

    for (var element in menus) {
      allMenus.addAll(element.menus!);
    }

    return allMenus;
  }
}
