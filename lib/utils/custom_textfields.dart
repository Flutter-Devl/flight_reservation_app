// ignore_for_file: unnecessary_null_comparison

import 'package:flight_reservation_app/constants.dart';
import 'package:flutter/material.dart';
import 'custom_divider.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields(
      {super.key,
      required this.icon,
      required this.title,
      this.obscureText,
      this.hintText,
      this.keyboardType,
      this.onChanged,
      this.onTap,
      this.focusNode,
      this.controller});

  final String title;
  final IconData icon;
  final bool? obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Icon(icon, color: kAccentColor),
              const SizedBox(width: 15.0),
              const CustomVerticalDivider(),
              const SizedBox(width: 10.0),
              Flexible(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                  obscureText: obscureText == null ? false : true,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kInactiveTextColor,
                    ),
                    border: InputBorder.none,
                    labelText: title,
                    labelStyle: const TextStyle(
                        color: kActiveTextColor, fontSize: 15.0),
                  ),
                  onChanged: onChanged,
                  onTap: onTap,
                ),
              )
            ],
          ),
        ),
        const CustomHorizontalDivider()
      ],
    );
  }
}
