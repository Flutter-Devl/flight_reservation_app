import 'package:flutter/material.dart';

import '../constants.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.heroTag});
  final IconData icon;
  final void Function()? onPressed;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: kAccentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Icon(icon, color: kPrimaryColor, size: 25.0),
      ),
    );
  }
}
