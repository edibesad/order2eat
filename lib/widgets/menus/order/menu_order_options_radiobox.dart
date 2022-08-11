import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order2eat/models/ordered_menu_model.dart';

import '../../../models/menu_model.dart';

// ignore: must_be_immutable
class MenuOrderOptionsRadioBox extends StatefulWidget {
  OrderedMenuModel menuToOrder;
  MenuOrderOptionsRadioBox(this.options, this.menuToOrder, {Key? key})
      : super(key: key);
  List<MenuOptions> options;

  @override
  State<MenuOrderOptionsRadioBox> createState() =>
      _MenuOrderOptionsRadioBoxState();
}

class _MenuOrderOptionsRadioBoxState extends State<MenuOrderOptionsRadioBox> {
  List<Map<String, dynamic>> radioboxData = [];
  @override
  void initState() {
    for (var element in widget.options) {
      radioboxData.add({
        "id": element.id,
        "name": element.name,
        "option": element,
        "group_value": null
      });
    }

    for (var item in radioboxData) {
      for (var element in jsonDecode(item["option"].subitems)) {
        widget.menuToOrder.optionsRadios.add({
          "value": false,
          "name": element["name"],
          "price": element["price"]
        });
      }
    }
    super.initState();
  }

  // late Map<String, dynamic> value;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var radio in radioboxData) {
      widgets.add(Text(radio["name"]));
      for (var element in jsonDecode(radio["option"].subitems)) {
        widgets.add(Row(
          children: [
            Radio<String>(
              value: element["name"],
              onChanged: (value) {
                setState(() {
                  radio["group_value"] = value;
                  for (var item in widget.menuToOrder.optionsRadios) {
                    item["value"] = false;
                  }
                  for (var item in widget.menuToOrder.optionsRadios) {
                    if (item["name"] == element["name"]) {
                      item["value"] = true;
                    }
                  }
                });
              },
              groupValue: radio["group_value"],
            ),
            Text(element["name"] + " (+" + element["price"] + ")"),
          ],
        ));
      }
      widgets.add(const SizedBox(
        height: 50,
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
