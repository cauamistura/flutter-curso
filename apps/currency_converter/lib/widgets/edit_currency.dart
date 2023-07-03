import 'package:flutter/material.dart';


class TextFieldCurr extends StatelessWidget {
  const TextFieldCurr({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefix,
    required this.changedFunction,
  });

  final Function(String) changedFunction;
  final TextEditingController controller;
  final String labelText, prefix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: labelText,
          prefixText: prefix,
          border: const OutlineInputBorder()),
      onChanged: changedFunction,
    );
  }
}
