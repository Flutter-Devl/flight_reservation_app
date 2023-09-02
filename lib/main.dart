import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/screens/main_screen.dart';
import 'package:flight_reservation_app/screens/profile_screen.dart';
import 'package:flight_reservation_app/screens/flights/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/ticket_data.dart';
import 'model/user_data.dart';
import 'screens/login_screen.dart';
import 'screens/my_flights.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketData()),
        ChangeNotifierProvider(create: (_) => TabControllerData()),
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flight Reservation System',
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          MainScreen.id: (context) => MainScreen(),
          MyFlights.id: (context) => const MyFlights(),
          TabsScreen.id: (context) => const TabsScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
