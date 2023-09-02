import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.navigatorIcon,
      required this.title,
      required this.onIconClick});
  final IconData navigatorIcon;
  final String title;
  final void Function()? onIconClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: onIconClick,
            child: Icon(navigatorIcon, color: kPrimaryColor, size: 30),
          ),
          const SizedBox(width: 50),
          Text(
            title,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
