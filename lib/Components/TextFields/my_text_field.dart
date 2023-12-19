import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyTextField extends StatefulWidget {
  final bool isPassword;
  final String hint;
  bool obsucreText;
  final TextEditingController controller;
  final bool formatted;
  final TextInputType keyboard;
  final readOnly;
  MyTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.obsucreText = false,
      this.formatted = true,
      this.isPassword = false,
      this.readOnly = false,
      this.keyboard = TextInputType.text});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
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
            keyboardType: widget.keyboard,
            readOnly: widget.readOnly,
            inputFormatters: [
              widget.formatted
                  ? FilteringTextInputFormatter.deny(
                      RegExp(r'\s')) // Deny spaces
                  : FilteringTextInputFormatter.deny(RegExp(r'')),
            ],
            controller: widget.controller,
            obscureText: widget.obsucreText,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.obsucreText = !widget.obsucreText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye_rounded))
                  : null,
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slide();
  }
}
