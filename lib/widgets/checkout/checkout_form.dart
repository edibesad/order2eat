import 'package:easy_localization/easy_localization.dart';
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
                "tax",
              ).tr(),
              Text(tax.toString())
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("price").tr(), Text(price.toString())],
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
                    const Text("credit_card").tr()
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Mobile Pay",
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
                    const Text("mobilepay").tr()
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
                    const Text("cash").tr()
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
                    const Text("sumup").tr()
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
                    const Text("show_detailed_options").tr(),
                  ],
                ),
                if (checkBoxValue!) ...showDetailedOptions(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("checkout").tr(),
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
      TextFormField(decoration: InputDecoration(hintText: "notes".tr())),
      Row(
        children: [
          if (!isCalculated!)
            DropdownButton<String>(
              value: dropDownValue,
              items: [
                DropdownMenuItem(
                  value: "cash",
                  child: const Text("fix_discount").tr(),
                ),
                DropdownMenuItem(
                  value: "procent",
                  child: Text("rate_discount").tr(),
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
                decoration: InputDecoration(hintText: "discount".tr()),
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
          children: [const Text("dsicount").tr(), Text(discount.toString())],
        ),
      DropdownButton<int>(
        value: estimatedDeliveryTime,
        hint: const Text("estimated_delivery_time").tr(),
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
        hint: const Text("ordered_from").tr(),
        items: [
          DropdownMenuItem(
            value: "Phone",
            child: Text("phone").tr(),
          ),
          DropdownMenuItem(
            value: "Restaurant",
            child: Text("restaurant").tr(),
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
        hint: const Text("is_payed").tr(),
        items: [
          DropdownMenuItem(
            value: true,
            child: Text("payment_made").tr(),
          ),
          DropdownMenuItem(
            value: false,
            child: Text("payment_not_made").tr(),
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
