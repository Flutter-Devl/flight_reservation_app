import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/custom_floating_action_button.dart';
import 'package:flight_reservation_app/utils/custom_divider.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class CheckoutTabScreen extends StatelessWidget {
  const CheckoutTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String gateNumber = '${randomAlpha(1).toUpperCase()}${randomNumeric(1)}';
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'checkout',
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          ticket.addGateNumber(gateNumber);
          ticket.addTicket();
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5.0),
                    AcronymCustomText(
                        text: ticket.from.substring(0, 3).toUpperCase()),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.from),
                    const SizedBox(height: 50.0),
                    const InactiveInfoCustomText(text: 'FLIGHT DATE'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.date),
                    const SizedBox(height: 40.0),
                    const InactiveInfoCustomText(text: 'BOARDING TIME'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.time ?? ''),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child:
                            ActiveInfoCustomText(text: ticket.duration ?? '')),
                    const SizedBox(height: 50.0),
                    const InactiveInfoCustomText(text: 'GATE'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: gateNumber),
                    const SizedBox(height: 53.0),
                    const InactiveInfoCustomText(text: 'SEAT'),
                    DropdownButton<String>(
                      icon: const Icon(null),
                      underline: const SizedBox(),
                      dropdownColor: kPrimaryColor,
                      items: ticket.seatsList.map((String dropDownItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownItem,
                          child: Text(
                            dropDownItem,
                            style: const TextStyle(
                              height: 0.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {},
                      value: ticket.seatsList[0],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 5.0),
                    AcronymCustomText(
                        text: ticket.to.substring(0, 3).toUpperCase()),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.to),
                    const SizedBox(height: 50.0),
                    const InactiveInfoCustomText(text: 'FLIGHT NO'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.flightNumber ?? ''),
                    const SizedBox(height: 40.0),
                    const InactiveInfoCustomText(text: 'CLASS'),
                    const SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.bookingClass ?? ''),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            const CustomHorizontalDivider(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total Price:',
                  style: TextStyle(color: kAccentColor, fontSize: 25.0),
                ),
                Text(
                  '\$${ticket.price}.00',
                  style: const TextStyle(color: kAccentColor, fontSize: 25.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
