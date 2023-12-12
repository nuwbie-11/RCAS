import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool obsucreText;
  final TextEditingController controller;
  final bool formatted;
  const MyTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.obsucreText = false,
    this.formatted = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: TextField(
            inputFormatters: [
              formatted
                  ? FilteringTextInputFormatter.deny(
                      RegExp(r'\s')) // Deny spaces
                  : FilteringTextInputFormatter.deny(RegExp(r'')),
            ],
            controller: controller,
            obscureText: obsucreText,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
