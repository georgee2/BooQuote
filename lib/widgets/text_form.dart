import 'package:flutter/material.dart';

class SimpleTextForm extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final bool obscure;
  final Widget icon;

  const SimpleTextForm({
    Key key,
    this.validator,
    this.label,
    this.controller,
    this.type,
    this.obscure,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
