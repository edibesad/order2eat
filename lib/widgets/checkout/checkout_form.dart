import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CheckOutForm extends StatefulWidget {
  CheckOutForm({Key? key, required this.price}) : super(key: key);
  late double price;

  @override
  State<CheckOutForm> createState() => _CheckOutFormState();
}

class _CheckOutFormState extends State<CheckOutForm> {
  String? _radioValue, dropDownValue = "cash", orderedFrom;
  bool? checkBoxValue = false, isCalculated = false, isPayed;
  double discount = 0;
  int? estimatedDeliveryTime;
  @override
  Widget build(BuildContext context) {
    double price = widget.price;
    double tax = price * 0.25;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tax",
              ),
              Text(tax.toString())
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Price"), Text(price.toString())],
        ),
        const Divider(
          thickness: 1,
        ),
        Expanded(
          flex: 10,
          child: Form(
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Radio(
                      value: "Credit Card",
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(
                          () {
                            _radioValue = value as String;
                          },
                        );
                        debugPrint(_radioValue);
                      },
                    ),
                    const Text("Credit Card")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Mobilie Pay",
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(
                          () {
                            _radioValue = value as String;
                          },
                        );
                        debugPrint(_radioValue);
                      },
                    ),
                    const Text("Mobilie Pay")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Cash",
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(
                          () {
                            _radioValue = value as String;
                          },
                        );
                        debugPrint(_radioValue);
                      },
                    ),
                    const Text("Cash")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Sumup",
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(
                          () {
                            _radioValue = value as String;
                          },
                        );
                        debugPrint(_radioValue);
                      },
                    ),
                    const Text("Sumup")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: checkBoxValue,
                        onChanged: (value) {
                          setState(() {
                            checkBoxValue = value!;
                          });
                        }),
                    const Text("Show Detailed Option"),
                  ],
                ),
                if (checkBoxValue!) ...showDetailedOptions(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Checkout"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  showDetailedOptions() {
    return [
      TextFormField(decoration: const InputDecoration(hintText: "Notes")),
      Row(
        children: [
          if (!isCalculated!)
            DropdownButton<String>(
              value: dropDownValue,
              items: const [
                DropdownMenuItem(
                  value: "cash",
                  child: Text("Discount in cash"),
                ),
                DropdownMenuItem(
                  value: "procent",
                  child: Text("Discount in procent"),
                ),
              ],
              onChanged: (value) {
                setState(
                  () {
                    dropDownValue = value;
                  },
                );
              },
            ),
          const SizedBox(
            width: 10,
          ),
          if (!isCalculated!)
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  discount = double.parse(value);
                },
                decoration: const InputDecoration(hintText: "discount"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
        ],
      ),
      if (!isCalculated!)
        ElevatedButton(
          onPressed: () {
            if (dropDownValue == "cash") {
              widget.price = widget.price - discount;
            } else {
              widget.price = widget.price * discount / 100;
            }
            isCalculated = true;
            setState(() {});
          },
          child: const Text("Calculate Discount"),
        ),
      if (isCalculated!)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Discount"), Text(discount.toString())],
        ),
      DropdownButton<int>(
        value: estimatedDeliveryTime,
        hint: const Text("Estimated Delivery Time"),
        items: const [
          DropdownMenuItem(
            value: 15,
            child: Text("15"),
          ),
          DropdownMenuItem(
            value: 20,
            child: Text("20"),
          ),
          DropdownMenuItem(
            value: 25,
            child: Text("25"),
          ),
          DropdownMenuItem(
            value: 30,
            child: Text("30"),
          ),
          DropdownMenuItem(
            value: 45,
            child: Text("45"),
          ),
          DropdownMenuItem(
            value: 60,
            child: Text("60"),
          ),
          DropdownMenuItem(
            value: 75,
            child: Text("75"),
          ),
        ],
        onChanged: (value) {
          setState(
            () {
              estimatedDeliveryTime = value!;
            },
          );
        },
      ),
      const SizedBox(
        width: 10,
      ),
      DropdownButton<String>(
        value: orderedFrom,
        hint: const Text("Ordered From"),
        items: const [
          DropdownMenuItem(
            value: "Phone",
            child: Text("Phone"),
          ),
          DropdownMenuItem(
            value: "Restaurant",
            child: Text("Restaurant"),
          ),
        ],
        onChanged: (value) {
          setState(
            () {
              orderedFrom = value!;
            },
          );
        },
      ),
      DropdownButton<bool>(
        value: isPayed,
        hint: const Text("Is payed?"),
        items: const [
          DropdownMenuItem(
            value: true,
            child: Text("Payed"),
          ),
          DropdownMenuItem(
            value: false,
            child: Text("NOT payed"),
          ),
        ],
        onChanged: (value) {
          setState(
            () {
              isPayed = value!;
            },
          );
        },
      ),
    ];
  }
}
