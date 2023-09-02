import 'package:flight_reservation_app/constants.dart';
import 'package:flutter/material.dart';

class ActiveInfoCustomText extends StatelessWidget {
  const ActiveInfoCustomText({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class CustomTabs extends StatelessWidget {
  const CustomTabs({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(text, style: const TextStyle(fontSize: 12.0)),
    );
  }
}

class AcronymCustomText extends StatelessWidget {
  const AcronymCustomText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: kAccentColor, fontSize: 35.0, fontWeight: FontWeight.w300),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: kPrimaryColor, fontSize: 20.0, fontWeight: FontWeight.w500),
    );
  }
}

class InactiveInfoCustomText extends StatelessWidget {
  const InactiveInfoCustomText({super.key, required this.text, this.height});

  final String text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height,
        color: kInactiveTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 15.0),
    );
  }
}
