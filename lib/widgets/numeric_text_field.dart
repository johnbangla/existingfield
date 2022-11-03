import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String label;
  final TextEditingController? controller;
  final bool? passwordField;
  final bool isNumeric;
  final bool? usernameField;
  final Color? textColor;
  final int? maxLines;

  const NumericTextField({
    Key? key,
    this.onChanged,
    this.controller,
    this.passwordField,
    this.onEditingComplete,
    this.onSubmitted,
    required this.isNumeric,
    this.usernameField,
    this.textColor,
    this.maxLines,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
//[FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
      // inputFormatters: isNumeric ?[WhitelistingTextInputFormatter.digitsOnly]:[],
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))],
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
      keyboardType: isNumeric == true ? TextInputType.numberWithOptions(decimal: false) : null,
         controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
      style: TextStyle(color: textColor),
      textInputAction: onEditingComplete != null ? TextInputAction.next : null,

    );
  }
}
