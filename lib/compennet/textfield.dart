import 'package:flutter/material.dart';

class MYTEXTFORM extends StatelessWidget {
  final TextEditingController controller1;
  final String hinttext;
  final bool obscuretext;
  FocusNode? focusenode;

  MYTEXTFORM(
      {super.key,
      required this.controller1,
      required this.hinttext,
      required this.obscuretext,
      this.focusenode});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        focusNode: focusenode,
        obscureText: obscuretext,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.onPrimary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.surface)),
            hintText: hinttext,
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            fillColor: Theme.of(context).colorScheme.onPrimary,
            filled: true),
        controller: controller1,
      ),
    ));
  }
}
