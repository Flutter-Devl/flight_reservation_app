// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/myAlert.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatTabScreen extends StatelessWidget {
  const SeatTabScreen({super.key, this.toggleTab});
  final toggleTab;
  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 50),
                        ActiveInfoCustomText(
                          text: '${ticket.duration}, ${ticket.time}',
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${ticket.bookingClass} Class',
                          style: const TextStyle(color: kAccentColor),
                        ),
                        const SizedBox(height: 10),
                        const TotalSeats()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(height: 65.0),
                        const SizedBox(height: 20.0),
                        ActiveInfoCustomText(text: ticket.duration ?? ''),
                        const SizedBox(height: 30.0),
                        AcronymCustomText(
                            text: ticket.to.substring(0, 3).toUpperCase()),
                        ActiveInfoCustomText(text: ticket.to),
                        const SizedBox(height: 30.0),
                        const InactiveInfoCustomText(text: 'FLIGHT NO'),
                        const SizedBox(height: 5.0),
                        ActiveInfoCustomText(text: ticket.flightNumber ?? ''),
                        const SizedBox(height: 30.0),
                        AcronymCustomText(text: ticket.seatNumber ?? ''),
                        const ActiveInfoCustomText(text: 'Seat'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalSeats extends StatelessWidget {
  const TotalSeats({super.key});

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);

    bool checkBookedTickets(String ticketNumber) {
      switch (ticket.bookingClass) {
        case 'Economy':
          return ticket.economyClassSeatsList.contains(ticketNumber);
        case 'Business':
          return ticket.businessClassSeatsList.contains(ticketNumber);
        case 'First':
          return ticket.firstClassSeatsList.contains(ticketNumber);
        default:
          return false;
      }
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SeatContainer(
                    seatNumber: '${index + 1}A',
                    isBooked: checkBookedTickets('${index + 1}A'),
                  ),
                  const SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}B',
                    isBooked: checkBookedTickets('${index + 1}B'),
                  ),
                  const SizedBox(width: 30.0),
                  SeatContainer(
                    seatNumber: '${index + 1}C',
                    isBooked: checkBookedTickets('${index + 1}C'),
                  ),
                  const SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}D',
                    isBooked: checkBookedTickets('${index + 1}D'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}

class SeatContainer extends StatefulWidget {
  const SeatContainer(
      {super.key, required this.isBooked, required this.seatNumber});
  final bool isBooked;
  final String seatNumber;

  @override
  _SeatContainerState createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  bool isSelected = false;

  void addticket(ticket) {
    isSelected = !isSelected;
    ticket.addSeat(widget.seatNumber);
    ticket.decreaseCount();
    if (ticket.getCount == 0) {
      Provider.of<TabControllerData>(context, listen: false).incrmentIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        switch (ticket.bookingClass) {
          case 'Economy':
            if (ticket.economyClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.economyClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
          case 'Business':
            if (ticket.businessClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.businessClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
          case 'First':
            if (ticket.firstClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.firstClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
        }
      },
      child: Container(
        height: 40.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: isSelected ? kAccentColor : const Color(0xFF5B7775),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          border: Border.all(
            color: widget.isBooked ? kAccentColor : kLinesColor,
          ),
        ),
      ),
    );
  }
}
