import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/custom_appbar.dart';
import 'package:flight_reservation_app/utils/custom_divider.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../constants.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context).tickets[index];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'My flights',
              navigatorIcon: Icons.clear,
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 10.0),
                                    const InactiveInfoCustomText(
                                        text: 'Ticket Price'),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          '${ticket.price}.00',
                                          style: const TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 30.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Expanded(
                                    child: Image(
                                        image: AssetImage('images/map.png'))),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            const CustomHorizontalDivider(),
                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const InactiveInfoCustomText(
                                        text: 'FLIGHT DATE'),
                                    InfoText(text: ticket.date ?? ''),
                                    const SizedBox(height: 40.0),
                                    const InactiveInfoCustomText(
                                        text: 'BOARDING TIME'),
                                    InfoText(text: ticket.time ?? ''),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const InactiveInfoCustomText(text: 'GATE'),
                                    InfoText(text: ticket.gateNumber ?? ''),
                                    const SizedBox(height: 53.0),
                                    const InactiveInfoCustomText(text: 'SEAT'),
                                    DropdownButton<String>(
                                      icon: const Icon(null),
                                      underline: const SizedBox(),
                                      items: ticket.seats
                                          ?.map((String dropDownItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownItem,
                                          child: Text(
                                            dropDownItem,
                                            style: const TextStyle(
                                              height: 0.0,
                                              color: kPrimaryColor,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {},
                                      value: ticket.seats?[0],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const InactiveInfoCustomText(
                                        text: 'FLIGHT NO'),
                                    InfoText(text: ticket.flightNumber ?? ''),
                                    const SizedBox(height: 40.0),
                                    const InactiveInfoCustomText(text: 'CLASS'),
                                    InfoText(text: ticket.bookingClass ?? ''),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            const CustomHorizontalDivider(),
                            const SizedBox(height: 30.0),
                            const InfoText(text: 'Boarding pass'),
                            const SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
