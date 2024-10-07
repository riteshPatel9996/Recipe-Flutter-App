// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
    this.maxLines,
    this.title,
    this.hintText,
    this.keybordType,
    this.type,
    this.obscureText,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.autofocus,
    this.textInputAction,
    this.borderColor,
    this.hintTextColor,
    this.inputFormatters,
    this.onChanged,
    this.filled,
    this.onTap,
    this.readOnly,
    this.maxLength,
    this.fillColor,
    this.textCapitalization,
  }) : super(key: key);
  final title;
  final hintText;
  final keybordType;
  final type;
  final maxLines;
  final obscureText;
  final validator;
  final controller;
  final suffixIcon;
  final focusNode;
  final onFieldSubmitted;
  final autofocus;
  final textInputAction;
  final borderColor;
  final hintTextColor;
  final inputFormatters;
  final onChanged;
  final filled;
  final onTap;
  final readOnly;
  final maxLength;
  final fillColor;
  final textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLength: maxLength,
      readOnly: readOnly == true ? true : false,
      // style: TextStyle(
      //     fontSize: 16,
      //     color: fillColor != null
      //         ? Color(0xff585A68)
      //         : Color(0xff585A68)),
      style: const TextStyle(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
      onTap: onTap,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      autocorrect: true,
      autofocus: autofocus == true ? true : false,
      keyboardType: keybordType,
      obscureText: obscureText == true ? true : false,
      decoration: InputDecoration(
        filled: filled == false ? false : true,
        fillColor: fillColor ?? Colors.white,
        counterText: "",
        isDense: true,
        contentPadding: const EdgeInsets.all(13),
        // type == "size"
        //     ? EdgeInsets.all(14)
        //     : EdgeInsets.all(10),
        hintStyle: const TextStyle(
            fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),

        hintText: hintText,
        helperStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        suffixIcon: suffixIcon,
        border: tFFNonBorder,
        //borderColor == "bColor" ? tFFColorBorder : tFFBorder,
        focusedBorder: tFFNonBorder,
        // borderColor == "bColor" ? tFFColorBorder : tFFBorder,
        enabledBorder: tFFNonBorder,
        //borderColor == "bColor" ? tFFColorBorder : tFFBorder,
        //enabledBorder: tFFBorder,
        errorBorder: tFFNonBorder,
        //disabledBorder: tFFBorder
      ),
    );
  }
}

const tFFBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(9),
    ),
    borderSide: BorderSide(color: Colors.black));

const tFFColorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(9),
    ),
    borderSide: BorderSide(color: Color(0xff009760)));

const tFFNonBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(9),
  ),
  borderSide: BorderSide(color: Colors.black12),
);

const tFFOneSideBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
      // bottomLeft: Radius.circular(8),
    ),
    borderSide: BorderSide(color: Colors.black));
