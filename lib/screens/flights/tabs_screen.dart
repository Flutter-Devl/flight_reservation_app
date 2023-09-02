import 'package:flight_reservation_app/utils/custom_appbar.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/screens/flights/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  static const String id = 'tabs_screen';

  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Add flight',
              navigatorIcon: Icons.clear,
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: const CustomTabbar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

