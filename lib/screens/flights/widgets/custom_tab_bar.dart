import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/screens/checkout/checkout_tab_screen.dart';
import 'package:flight_reservation_app/screens/flights/flight_tab_screen.dart';
import 'package:flight_reservation_app/screens/flights/route_tab_screen.dart';
import 'package:flight_reservation_app/screens/flights/seat_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  _CustomTabbarState createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    _tabController?.animateTo(Provider.of<TabControllerData>(context).tabIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: kLinesColor.withOpacity(0.0),
              border: const Border(
                  bottom: BorderSide(color: kLinesColor, width: 0.8))),
          child: Center(
            child: IgnorePointer(
              child: TabBar(
                controller: _tabController,
                labelColor: kAccentColor,
                unselectedLabelColor: kInactiveTextColor,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                tabs: const [
                  Tab(text: 'Route'),
                  Tab(text: 'Flight'),
                  Tab(text: 'Seat'),
                  Tab(text: 'Checkout'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              const RouteTabScreen(),
              FlightTabScreen(),
              const SeatTabScreen(),
              const CheckoutTabScreen(),
            ],
          ),
        )
      ],
    );
  }
}
