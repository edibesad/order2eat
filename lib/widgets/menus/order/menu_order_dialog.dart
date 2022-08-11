import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order2eat/widgets/menus/order/menu_order_options.dart';
import '../../../models/menu_model.dart';
import '../../../models/ordered_menu_model.dart';
import '../../../providers/all_providers.dart';

// ignore: must_be_immutable
class MenuOrderDialog extends ConsumerWidget {
  Menus menu;
  MenuOrderDialog({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OrderedMenuModel menuToOrder =
        OrderedMenuModel(menu: menu, quantity: 1, price: 0);
    TextEditingController quantityController = TextEditingController(),
        priceController = TextEditingController();
    quantityController.text = "1";
    priceController.text = menu.price.toString();
    final formKey = GlobalKey<FormState>();

    return SizedBox(
      height: 1000,
      width: 800,
      child: ListView(children: [
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                // child: Image.network(
                //   menu.image!,
                // ),
                child: CachedNetworkImage(
                  imageUrl: menu.image!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                menu.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(menu.description ?? ""),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("Quantity")),
                        Expanded(
                          child: TextFormField(
                            controller: quantityController,
                            onChanged: (value) {},
                            decoration: const InputDecoration(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: ((value) {
                              if (value!.isEmpty || value == "") {
                                return "Can't be empty";
                              }
                              return null;
                            }),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(child: Text("Price")),
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
                            onChanged: (value) {},
                            decoration: const InputDecoration(),
                            keyboardType: TextInputType.number,
                            validator: ((value) {
                              if (value!.isEmpty || value == "") {
                                return "Can't be empty";
                              }
                              if (double.tryParse(value) == null) {
                                return "Enter a valid value";
                              }
                              return null;
                            }),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    MenuOrderOptions(menu.options, menuToOrder),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            menuToOrder.quantity =
                                int.parse(quantityController.text);

                            menuToOrder.price =
                                double.parse(priceController.text);

                            for (var group in menuToOrder.optionsCheckbox) {
                              for (var element in group["data"]) {
                                if (element["value"]) {
                                  menuToOrder.price = menuToOrder.price +
                                      double.parse(element["price"]);
                                }
                              }
                            }
                            for (var element in menuToOrder.optionsRadios) {
                              if (element["value"]) {
                                menuToOrder.price = menuToOrder.price +
                                    double.parse(element["price"]);
                              }
                            }

                            for (var element in menuToOrder.optionsDropdown) {
                              if (element["value"] != null) {
                                menuToOrder.price = menuToOrder.price +
                                    double.parse(element["value"]["price"]);
                              }
                            }

                            ref
                                .read(orderedMenusNotifier.notifier)
                                .addMenu(menuToOrder);
                            Fluttertoast.showToast(
                                msg: "Added to basket", fontSize: 16.0);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add to basket"))
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Scaffold withScaffold(
      GlobalKey<FormState> formKey,
      TextEditingController quantityController,
      TextEditingController priceController,
      WidgetRef ref,
      BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                  menu.image!,
                ),
              ),
              Text(
                menu.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(menu.description ?? ""),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("Quantity")),
                        Expanded(
                          child: TextFormField(
                            controller: quantityController,
                            onChanged: (value) {},
                            decoration: const InputDecoration(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: ((value) {
                              if (value!.isEmpty || value == "") {
                                return "Can't be empty";
                              }
                              return null;
                            }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Price")),
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
                            onChanged: (value) {},
                            decoration: const InputDecoration(),
                            keyboardType: TextInputType.number,
                            validator: ((value) {
                              if (value!.isEmpty || value == "") {
                                return "Can't be empty";
                              }
                              if (double.tryParse(value) == null) {
                                return "Enter a valid value";
                              }
                              return null;
                            }),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref.read(orderedMenusNotifier.notifier).addMenu(
                                  OrderedMenuModel(
                                    menu: menu,
                                    quantity:
                                        int.parse(quantityController.text),
                                    price: double.parse(priceController.text),
                                  ),
                                );
                            Fluttertoast.showToast(
                                msg: "Added to basket", fontSize: 16.0);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Add to basket"))
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
