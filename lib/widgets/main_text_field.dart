import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String label;
  final TextEditingController? controller;
  final bool? passwordField;
  final bool? emailField;
  final bool? usernameField;
  final Color? textColor;
  final int? maxLines;

  const MainTextField({
    Key? key,
    this.onChanged,
    this.controller,
    this.passwordField,
    this.onEditingComplete,
    this.onSubmitted,
    this.emailField,
    this.usernameField,
    this.textColor,
    this.maxLines,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, 0.1),
        border: OutlineInputBorder(),
        hintText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(color: textColor),
      ),
      keyboardType: emailField == true ? TextInputType.emailAddress : null,
      obscureText: passwordField ?? false,
      maxLength: passwordField == true ? 60 : null,
      autocorrect: usernameField != true && emailField != true,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
      style: TextStyle(color: textColor),
      textInputAction: onEditingComplete != null ? TextInputAction.next : null,
      maxLines: maxLines,
    );
  }
}
