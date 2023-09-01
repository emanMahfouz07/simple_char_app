import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  CustomFormTextField(
      {Key? key,
      required this.onChanged,
      this.hintText,
      this.isPassword = false})
      : super(key: key);
  String? hintText;
  bool isPassword;

  Function(String)? onChanged;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  String? icon;
  bool showPwd = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && !showPwd,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(showPwd ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPwd = !showPwd;
                  });
                })
            : null,
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
