import 'package:flutter/material.dart';

class ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType type;
  final bool isPassword;

  const ProfileInputField({Key key, this.controller, this.hint, this.type, this.isPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: hint,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
