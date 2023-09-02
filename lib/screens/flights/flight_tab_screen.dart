import 'dart:math';

import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flight_reservation_app/screens/flights/widgets/ticket_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FlightTabScreen extends StatelessWidget {
  FlightTabScreen({super.key, this.toggleTab});
  final Function? toggleTab;
  final int randomNumber = Random().nextInt(15) + 1;

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Text(
              '$randomNumber flights avaliable from ${ticket.from.substring(0, 3).toUpperCase()} to ${ticket.to.substring(0, 3).toUpperCase()}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          TicketsList(
            listLenght: randomNumber,
            listLength: randomNumber,
          ),
        ],
      ),
    );
  }
}
