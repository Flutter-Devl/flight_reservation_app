import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/custom_divider.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flight_reservation_app/model/flight_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class CustomFlightCard extends StatelessWidget {
  final FlightData flightData;

  const CustomFlightCard({Key? key, required this.flightData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<TicketData>(context);

    return GestureDetector(
      onTap: () {
        Provider.of<TicketData>(context, listen: false).addflightData(
          flightData.flightNo,
          flightData.flightDuration,
          flightData.flightTime,
          flightData.price,
        );
        Provider.of<TabControllerData>(context, listen: false).incrmentIndex();
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      AcronymCustomText(
                          text: ticket.from.substring(0, 3).toUpperCase()),
                      const SizedBox(height: 5.0),
                      ActiveInfoCustomText(
                        text: ticket.from,
                        color: kDateTimeAndCitesColor,
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ActiveInfoCustomText(
                        text:
                            '${flightData.flightDuration}, ${flightData.flightTime}',
                        color: kDateTimeAndCitesColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      AcronymCustomText(
                          text: ticket.to.substring(0, 3).toUpperCase()),
                      const SizedBox(height: 5.0),
                      ActiveInfoCustomText(
                        text: ticket.to,
                        color: kDateTimeAndCitesColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomHorizontalDivider(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    height: 30.0,
                    width: 70.0,
                    child: Image(
                      image: AssetImage('images/bottom_logos.png'),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        'Ticket Price',
                        style: TextStyle(
                          color: kInactiveColor,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '\$${flightData.price}.00',
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: kActiveColor,
                        ),
                      ),
                    ],
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

class TicketsList extends StatelessWidget {
  const TicketsList({Key? key, required this.listLength, required int listLenght}) : super(key: key);
  final int listLength;

  FlightData generateFlightData() {
    final flightNo = '${randomAlpha(2).toUpperCase()}${randomBetween(10, 99)}';
    final timeInMinutes = randomBetween(30, 1440);
    final hours = (timeInMinutes ~/ 60).toInt();
    final minutes = timeInMinutes - (hours * 60);
    final flightDuration = '$hours h ${minutes.toString().padLeft(2, '0')} m';
    final timeInMinutes2 = randomBetween(0, 1440);
    final hours2 = (timeInMinutes2 ~/ 60).toInt();
    final minutes2 = timeInMinutes2 - (hours2 * 60);
    final timePeriod = hours2 > 11 ? 'PM' : 'AM';
    final flightTime =
        '$hours2:${minutes2.toString().padLeft(2, '0')} $timePeriod';
    final price = randomBetween(100, 150);

    return FlightData(
      flightNo: flightNo,
      flightDuration: flightDuration,
      flightTime: flightTime,
      price: price,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<FlightData> flightDataList =
        List.generate(listLength, (index) => generateFlightData());

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final selectedTicket = flightDataList[index];
            return CustomFlightCard(flightData: selectedTicket);
          },
          itemCount: listLength,
        ),
      ),
    );
  }
}
