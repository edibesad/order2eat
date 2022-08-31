import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/menu_model.dart';
import '../order/menu_order_dialog.dart';

// ignore: must_be_immutable
class MenusGridViewElement extends ConsumerWidget {
  MenusGridViewElement({Key? key, required this.menu}) : super(key: key);
  Menus menu;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: MenuOrderDialog(menu: menu));
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        child: Stack(
          children: [
            // Image.network(menu.imageThumb!),
            Positioned.fill(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: menu.imageThumb!,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  menu.name!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
