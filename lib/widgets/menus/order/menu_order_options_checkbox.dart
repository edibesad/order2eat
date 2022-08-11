import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/menu_model.dart';
import 'package:order2eat/models/ordered_menu_model.dart';

// ignore: must_be_immutable
class MenuOrderOptionsCheckBoxes extends StatefulWidget {
  List<MenuOptions> checkboxes;
  OrderedMenuModel menuToOrder;
  MenuOrderOptionsCheckBoxes(this.checkboxes, this.menuToOrder, {Key? key})
      : super(key: key);

  @override
  State<MenuOrderOptionsCheckBoxes> createState() =>
      _MenuOrderOptionsCheckBoxesState();
}

class _MenuOrderOptionsCheckBoxesState
    extends State<MenuOrderOptionsCheckBoxes> {
  List<Map<String, dynamic>> checkboxesMap = [];
  @override
  void initState() {
    for (var element in widget.checkboxes) {
      // checkboxesMap.add({"value": true, "data": element});
      var subitems = jsonDecode(element.subitems!);

      checkboxesMap.add({
        "name": element.name,
        "data": [
          for (var subitem in subitems)
            {"value": false, "name": subitem["name"], "price": subitem["price"]}
        ]
      });
      widget.menuToOrder.optionsCheckbox.addAll(checkboxesMap);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var option in checkboxesMap) {
      widgets.add(Text(option["name"]));
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var subitem in option["data"])
            Center(
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Row(children: [
                    Text(subitem["name"]),
                    Checkbox(
                      value: subitem["value"],
                      onChanged: ((value) {
                        setState(() {
                          subitem["value"] = !subitem["value"];
                          for (var element
                              in widget.menuToOrder.optionsCheckbox) {
                            if (element["name"] == subitem["name"]) {
                              element["value"] = subitem["value"];
                            }
                          }
                        });
                      }),
                    ),
                  ]);
                },
              ),
            )
        ],
      ));
      widgets.add(const SizedBox(
        height: 30,
      ));
    }
    return Column(
      children: widgets,
      // children: [
      //   for (var element in checkboxesMap)
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Checkbox(
      //           value: element["value"],
      //           onChanged: (value) {
      //             setState(() {
      //               element["value"] = !element["value"];
      //             });
      //           },
      //         ),
      //         // Text(element["data"]["name"]),
      //       ],
      //     )
      // ],
    );
  }
}
