import 'package:flight_reservation_app/constants.dart';
import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 0.0, thickness: 1.5, color: kLinesColor);
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 55.0, color: kLinesColor);
  }
}