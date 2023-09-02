import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flight_reservation_app/screens/boarding_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFlights extends StatelessWidget {
  static const String id = 'myFlight_screen';

  const MyFlights({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        ),
        child: const TicketsList(),
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  const TicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketData>(
      builder: (context, ticketData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var ticket = ticketData.tickets[index];
            return Ticket(
              index: index,
              from: ticket.from ?? '',
              to: ticket.to ?? '',
              time: ticket.time ?? '',
              duration: ticket.duration ?? '',
              date: ticket.date ?? '',
              flightNumber: ticket.flightNumber ?? '',
            );
          },
          itemCount: ticketData.totalTickets,
        );
      },
    );
  }
}

class Ticket extends StatelessWidget {
  const Ticket({super.key, 
    required this.index,
    this.from,
    this.to,
    this.date,
    this.time,
    this.duration,
    this.flightNumber,
  });
  final int index;
  final String? from;
  final String? to;
  final String? date;
  final String? time;
  final String? duration;
  final String? flightNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardingPassScreen(index: index),
              ),
            );
          },
          child: Container(
            color: kPrimaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5.0),
                    AcronymCustomText(text: from!.substring(0, 3).toUpperCase()),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: from??''),
                    const SizedBox(height: 30.0),
                    const InactiveInfoCustomText(text: 'DATE'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: '$date, $time'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ActiveInfoCustomText(text: duration??''),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      AcronymCustomText(text: to!.substring(0, 3).toUpperCase()),
                      const SizedBox(height: 5.0),
                      ActiveInfoCustomText(text: to??''),
                      const SizedBox(height: 30.0),
                      const InactiveInfoCustomText(text: 'FLIGHT NO'),
                      const SizedBox(height: 5.0),
                      ActiveInfoCustomText(text: flightNumber??''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        const Divider(thickness: 1.5, color: kLinesColor),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
