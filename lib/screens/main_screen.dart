import 'package:flight_reservation_app/utils/custom_appbar.dart';
import 'package:flight_reservation_app/utils/custom_floating_action_button.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flight_reservation_app/model/user_data.dart';
import 'package:flight_reservation_app/screens/my_flights.dart';
import 'package:flight_reservation_app/screens/profile_screen.dart';
import 'package:flight_reservation_app/screens/flights/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    void navigateToScreen(String screenId) {
      Navigator.pushNamed(context, screenId);
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    Text(
                      user.username,
                      style: const TextStyle(color: kAccentColor, fontSize: 30),
                    ),
                    Text(
                      user.email ?? '',
                      style: const TextStyle(color: kAccentColor),
                    ),
                  ],
                ),
              ),
            ),
            buildListTile(Icons.person, 'Profile', () {
              navigateToScreen(ProfileScreen.id);
            }),
            buildListTile(Icons.settings, 'Settings', () {
              Navigator.pop(context);
            }),
            buildListTile(Icons.arrow_back, 'Logout', () {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'My flights',
              navigatorIcon: Icons.menu,
              onIconClick: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            const SizedBox(height: 20.0),
            const MyFlights(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'main',
        icon: Icons.add,
        onPressed: () {
          Provider.of<TabControllerData>(context, listen: false).initialIndex();
          Provider.of<TicketData>(context, listen: false).seatsList.clear();
          navigateToScreen(TabsScreen.id);
        },
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: kPrimaryColor),
      ),
      onTap: () => onTap(),
    );
  }
}
