import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/constants/ui_helper.dart';
import 'package:order2eat/providers/all_providers.dart';
import '../models/ordered_menu_model.dart';

class OrderedMenus extends ConsumerWidget {
  const OrderedMenus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderedMenus =
        List<OrderedMenuModel>.from(ref.watch(orderedMenusNotifier));
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: orderedMenus.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: UIHelper.getBasketTextPadding(),
                              child: Text(
                                orderedMenus[index].menu.name!,
                              ))),
                      Text(
                        "${orderedMenus[index].quantity}x${orderedMenus[index].price}",
                      ),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(orderedMenusNotifier.notifier)
                                .deleteMenu(orderedMenus[index].id);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
