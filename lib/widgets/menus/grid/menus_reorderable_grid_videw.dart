import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/widgets/menus/filter/menus_filter_field.dart';
import 'package:order2eat/widgets/menus/grid/menus_grid_view_element.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:sized_context/sized_context.dart';

import '../../../models/menu_model.dart';
import '../../../providers/all_providers.dart';

// ignore: must_be_immutable
class MenusReorderableGridView extends ConsumerStatefulWidget {
  List<MenuModel> mainMenus;

  MenusReorderableGridView(this.mainMenus, {Key? key}) : super(key: key);

  @override
  ConsumerState<MenusReorderableGridView> createState() =>
      _MenusReorderableGridViewState();
}

class _MenusReorderableGridViewState
    extends ConsumerState<MenusReorderableGridView> {
  late List<Menus> filteredMenus;

  @override
  Widget build(BuildContext context) {
    var allMenus = ref.watch(allMenusProvider.state).state;
    filteredMenus = ref.watch(filteredMenusProvider.state).state;
    String menuSearchText = ref.watch(menuSearchTextProvider.state).state;
    // List<Menus> allMenus = ref.watch(allMenusProvider.state).state;
    if (ref.read(dropdowndMenuValueProvider.state).state == -1) {
      filteredMenus = allMenus;
      // ref.read(filteredMenusProvider.state).state = allMenus;
    }
    if (menuSearchText.isNotEmpty || menuSearchText != "") {
      filteredMenus = filteredMenus.where(
        (menu) {
          final menuName = menu.name!.toLowerCase();
          return menuName.contains(menuSearchText.toLowerCase());
        },
      ).toList();
      // filteredMenus = ref.watch(filteredMenusProvider.state).state.where(
      //   (menu) {
      //     final menuName = menu.name!.toLowerCase();
      //     return menuName.contains(menuSearchText.toLowerCase());
      //   },
      // ).toList();
    }
    return Column(
      children: [
        MenusFilterField(widget.mainMenus),
        Expanded(
            child: ReorderableGridView.builder(
          onReorder: (int oldIndex, int newIndex) {
            setState(
              () {
                if (ref.read(dropdowndMenuValueProvider.state).state == -1) {
                  final item = allMenus.removeAt(oldIndex);
                  allMenus.insert(newIndex, item);
                  ref.read(allMenusProvider.state).state = allMenus;
                  filteredMenus = allMenus;
                } else {
                  final item = filteredMenus.removeAt(oldIndex);
                  filteredMenus.insert(newIndex, item);
                }
                updateMenu(filteredMenus, ref);
              },
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.diagonalInches >= 8 ? 4 : 3),
          itemBuilder: (context, index) {
            return Card(
                key: ValueKey(filteredMenus[index].id),
                child: MenusGridViewElement(menu: filteredMenus[index]));
          },
          itemCount: filteredMenus.length,
        ))
      ],
    );
  }
}

void updateMenu(List<Menus> filteredMenus, WidgetRef ref) async {
  if (ref.read(dropdowndMenuValueProvider.state).state != -1) {
    var menusCollection = FirebaseFirestore.instance.collection("menus").get();
    menusCollection.then((value) {
      for (var doc in value.docs) {
        for (var menu in doc["menus"]) {
          for (var element in filteredMenus) {
            if (element.id == menu["id"]) {
              List<Map<String, dynamic>> filteredMenusMap = [
                for (var key in filteredMenus) key.toJson()
              ];

              FirebaseFirestore.instance
                  .collection("menus")
                  .doc(doc.id)
                  .update({"menus": filteredMenusMap}).whenComplete(() {});

              return;
            }
          }
        }
      }
    });
  } else if (ref.read(dropdowndMenuValueProvider.state).state == -1 &&
      (ref.read(menuSearchTextProvider.state).state.isEmpty ||
          ref.read(menuSearchTextProvider.state).state == "")) {
    FirebaseFirestore.instance
        .collection("subMenus")
        .doc("UGDtwwbLi2TRTLGbfTDc")
        .update({
      "allSubMenus": [
        for (var element in filteredMenus) element.toJson(),
      ]
    });
    FirebaseFirestore.instance
        .collection("subMenus")
        .doc("UGDtwwbLi2TRTLGbfTDc")
        .get()
        .then((value) {
      // for (var element in value.data()!["subMenus"]) {}
      ref.read(allMenusProvider.state).state = [
        for (var element in value.data()!["allSubMenus"])
          Menus.fromJson(element),
      ];
    });
  }
}

//TODO: Firebase'e tüm menülerin tutulduğu bir döküman yada koleksiyon açıp.
// Tüm menüler orda tutulup sıra ordan değiştirilecek. updateMenu fonkisyonu 
//uyumlu hale getirilecek