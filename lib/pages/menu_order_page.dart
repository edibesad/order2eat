import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/menu_model.dart';

// ignore: must_be_immutable
class MenuOrderPage extends StatelessWidget {
  Menus menu;
  MenuOrderPage({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController(),
        priceController = TextEditingController();
    quantityController.text = "1";
    priceController.text = menu.price.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name!),
      ),
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
              Text(menu.description!),
              const SizedBox(
                height: 20,
              ),
              Form(
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
                            onChanged: (value) {
                              priceController.text = value;
                            },
                            decoration: const InputDecoration(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
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
