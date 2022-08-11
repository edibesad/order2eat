import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/providers/all_providers.dart';

class MenusFilterTextField extends ConsumerStatefulWidget {
  const MenusFilterTextField({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenusFilterTextFieldState createState() => _MenusFilterTextFieldState();
}

class _MenusFilterTextFieldState extends ConsumerState<MenusFilterTextField> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = ref.read(menuSearchTextProvider.state).state;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        ref
            .read(menuSearchTextProvider.state)
            .update((state) => textEditingController.text);
      },
      controller: textEditingController,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            textEditingController.text = "";
            ref.read(menuSearchTextProvider.state).state = "";
          },
        ),
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}
