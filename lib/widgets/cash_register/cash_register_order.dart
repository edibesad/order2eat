import 'package:flutter/material.dart';

import '../../models/menu_model.dart';

// ignore: must_be_immutable
class CashRegisterOrder extends StatefulWidget {
  List<Menus> orderedMenus;
  CashRegisterOrder({Key? key, required this.orderedMenus}) : super(key: key);

  @override
  State<CashRegisterOrder> createState() => _CashRegisterOrderState();
}

class _CashRegisterOrderState extends State<CashRegisterOrder> {
  @override
  Widget build(BuildContext context) {
    var orderedMenus = widget.orderedMenus;
    return Column(
      children: [
        ListView.builder(itemBuilder: (context, index) {
          Menus menu = orderedMenus[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menu.name!,
              ),
              Text(
                menu.price.toString(),
              ),
            ],
          );
        }),
      ],
    );
  }
}
