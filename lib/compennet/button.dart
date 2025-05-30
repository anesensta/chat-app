import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const Button({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 60,
          width: 320,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
