import 'package:flutter/material.dart';
import 'package:order2eat/models/menu_model.dart';
import 'package:order2eat/models/ordered_menu_model.dart';
import 'package:order2eat/widgets/menus/order/menu_order_options_checkbox.dart';
import 'package:order2eat/widgets/menus/order/menu_order_options_dropdown.dart';
import 'package:order2eat/widgets/menus/order/menu_order_options_radiobox.dart';

// ignore: must_be_immutable
class MenuOrderOptions extends StatelessWidget {
  final List<MenuOptions>? options;
  OrderedMenuModel menuToOrder;
  MenuOrderOptions(this.options, this.menuToOrder, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuOptions> checkboxes = [];
    List<MenuOptions> radioboxes = [];
    List<MenuOptions> selectboxes = [];
    for (var element in options!) {
      if (element.type!.contains("checkbox")) {
        // checkboxes.addAll(jsonDecode(element.subitems!));
        checkboxes.add(element);
        // checkboxes = jsonDecode(element.subitems!);
      } else if (element.type!.contains("radiobox")) {
        // radioboxes.addAll(jsonDecode(element.subitems!));
        // radioboxes = jsonDecode(element.subitems!);
        radioboxes.add(element);
      } else if (element.type!.contains("selectbox")) {
        selectboxes.add(element);
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 80,
        ),
        MenuOrderOptionsCheckBoxes(checkboxes, menuToOrder),
        const Divider(thickness: 2),
        MenuOrderOptionsRadioBox(radioboxes, menuToOrder),
        const Divider(thickness: 2),
        MenuOptionsDropdown(selectboxes, menuToOrder),
      ],
    );
  }
}
