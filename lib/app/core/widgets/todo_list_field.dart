import 'package:flutter/material.dart';

import 'package:modulo_17_todo_list/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {

  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  final ValueNotifier<bool> _obscureTextVN;

  TodoListField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    this.focusNode,
  }) : 
  assert(obscureText ? suffixIconButton == null : true, "obscureText must be false when suffixIconButton is not null"),
  _obscureTextVN = ValueNotifier(obscureText),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            isDense: true,
            suffixIcon: _getSuffixIcon(),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }

  Widget? _getSuffixIcon() {
    if(suffixIconButton != null) {
      return suffixIconButton;
    }

    if(obscureText) {
      return IconButton(
        onPressed: () {
          _obscureTextVN.value = !_obscureTextVN.value;
        }, 
        icon: Icon(
          _obscureTextVN.value ? TodoListIcons.eye : TodoListIcons.eye_slash,
          size: 15,
        ),
      );
    }

    return null;
  }
}
