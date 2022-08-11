import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/providers/all_providers.dart';

import '../../pages/ordered_menus.dart';
import '../checkout/checkout_form.dart';

class CashRegisterCheckout extends ConsumerWidget {
  const CashRegisterCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double price = 0;
    for (var element in ref.watch(orderedMenusNotifier)) {
      price = price + (element.quantity * element.price);
    }
    return Column(
      children: [
        const Expanded(flex: 1, child: OrderedMenus()),
        Expanded(
          flex: 3,
          child: CheckOutForm(
            price: price,
          ),
        ),
      ],
    );
  }
}
