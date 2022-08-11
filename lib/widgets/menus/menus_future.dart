import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/services/menu_api.dart';
import 'package:order2eat/widgets/menus/grid/menus_reorderable_grid_videw.dart';

import '../../models/menu_model.dart';

class MenusFuture extends ConsumerStatefulWidget {
  const MenusFuture({Key? key}) : super(key: key);

  @override
  ConsumerState<MenusFuture> createState() => _MenusFutureState();
}

class _MenusFutureState extends ConsumerState<MenusFuture> {
  late Future<List<MenuModel>> _menusFuture;
  @override
  void initState() {
    super.initState();
    _menusFuture = MenuApi.getMenusFromFirebase(ref);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuModel>>(
      future: _menusFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MenusReorderableGridView(snapshot.data!);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
