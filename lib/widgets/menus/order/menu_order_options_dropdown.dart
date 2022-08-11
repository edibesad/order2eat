import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/menu_model.dart';
import '../../../models/ordered_menu_model.dart';

// ignore: must_be_immutable
class MenuOptionsDropdown extends StatefulWidget {
  OrderedMenuModel menuToOrder;
  List<MenuOptions> options;

  MenuOptionsDropdown(this.options, this.menuToOrder, {Key? key})
      : super(key: key);

  @override
  State<MenuOptionsDropdown> createState() => _MenuOptionsDropdown();
}

class _MenuOptionsDropdown extends State<MenuOptionsDropdown> {
  List<Map<String, dynamic>> dropdownData = [];
  @override
  void initState() {
    for (var element in widget.options) {
      dropdownData.add({
        "id": element.id,
        "name": element.name,
        "subitems": jsonDecode(element.subitems!),
        "value": null
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var dropdown in dropdownData) {
      // widgets.add(Text(dropdown["name"]));
      widgets.add(DropdownButton<Map<String, dynamic>>(
        hint: Text(dropdown["name"] + " (Optional)"),
        value: dropdown["value"],
        items: [
          for (var element in dropdown["subitems"])
            DropdownMenuItem(
              value: element,
              child: Text("${element["name"]} (+${element["price"]})"),
            )
        ],
        onChanged: (value) {
          setState(() {
            dropdown["value"] = value;
          });
        },
      ));
    }
    widget.menuToOrder.optionsDropdown = dropdownData;
    return Column(
      children: widgets,
    );
  }
}
