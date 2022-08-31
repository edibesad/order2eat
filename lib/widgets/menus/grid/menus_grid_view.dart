import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/menu_model.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:order2eat/widgets/menus/filter/menus_filter_field.dart';

import 'menus_grid_view_element.dart';

// ignore: must_be_immutable
class MenusGridView extends ConsumerWidget {
  List<MenuModel> mainMenus;
  MenusGridView(this.mainMenus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var filteredMenus = ref.read(filteredMenusProvider.state).state;
    return Column(
      children: [
        MenusFilterField(mainMenus),
        Expanded(
          child: GridView.builder(
              itemCount: filteredMenus.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6),
              itemBuilder: (context, index) {
                return MenusGridViewElement(menu: filteredMenus[index]);
              }),
        ),
      ],
    );
  }
}



// final element = ref
//                   .read(filteredMenusProvider.state)
//                   .state
//                   .removeAt(oldIndex);
//               ref
//                   .read(filteredMenusProvider.state)
//                   .state
//                   .insert(newIndex, element);
