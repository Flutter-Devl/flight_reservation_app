import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/custom_floating_action_button.dart';
import 'package:flight_reservation_app/utils/custom_divider.dart';
import 'package:flight_reservation_app/utils/custom_textfields.dart';
import 'package:flight_reservation_app/utils/myAlert.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/tab_controller_data.dart';
import 'package:flight_reservation_app/model/ticket_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RouteTabScreen extends StatefulWidget {
  const RouteTabScreen({super.key});

  @override
  _RouteTabScreenState createState() => _RouteTabScreenState();
}

class _RouteTabScreenState extends State<RouteTabScreen> {
  String? from;
  String? to;
  late String date;
  String? returnDate;
  int? travelers;
  String? bookingClass;
  final _bookingClassList = ['Economy', 'Business', 'First'];
  final _dateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15.0),
            Expanded(
              child: DefaultTabController(
                length: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: kLinesColor.withOpacity(0.0),
                        border: const Border(
                          bottom: BorderSide(color: kLinesColor, width: 0.8),
                        ),
                      ),
                      child: const Center(
                        child: TabBar(
                          labelColor: kAccentColor,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          tabs: [CustomTabs(text: 'One Way')],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              const SizedBox(height: 25.0),
                              CustomTextFields(
                                icon: Icons.flight_takeoff,
                                title: 'FROM',
                                onChanged: (newSource) {
                                  from = newSource;
                                },
                              ),
                              const SizedBox(height: 25.0),
                              CustomTextFields(
                                icon: Icons.flight_land,
                                title: 'TO',
                                onChanged: (newDestination) {
                                  to = newDestination;
                                },
                              ),
                              const SizedBox(height: 25.0),
                              buildDateField(context),
                              const SizedBox(height: 25.0),
                              CustomTextFields(
                                icon: Icons.people,
                                title: 'TRAVELER',
                                keyboardType: TextInputType.number,
                                onChanged: (numberOfTravelers) {
                                  travelers = int.tryParse(numberOfTravelers);
                                },
                              ),
                              const SizedBox(height: 25.0),
                              buildBookingClassDropdown(),
                              const SizedBox(height: 25.0),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'route',
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          if (isEmptyField()) {
            MyAlert.errorAlert(context,
                desc: "One of the field is empty. Fill all the fields");
          } else {
            var flight = Provider.of<TicketData>(context, listen: false);
            if (checkNoSeatsAvailability(flight)) {
              MyAlert.noSeatsAlert(context, bookingClass: bookingClass ?? '');
            } else {
              flight.addRouteData(from ?? '', to ?? '', date, travelers ?? 0,
                  bookingClass ?? '');
              Provider.of<TabControllerData>(context, listen: false)
                  .incrmentIndex();
            }
          }
        },
      ),
    );
  }

  bool isEmptyField() {
    return from == null ||
        to == null ||
        date.isEmpty ||
        travelers == null ||
        bookingClass == null;
  }

  Widget buildDateField(BuildContext context) {
    return CustomTextFields(
      icon: Icons.date_range,
      controller: _dateController,
      title: 'DATE',
      onTap: () {
        FocusScope.of(context).unfocus();
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        ).then((date) {
          this.date = DateFormat('MMM d').format(date!);
          setState(() {
            _dateController.text = this.date;
          });
        });
      },
    );
  }

  Widget buildBookingClassDropdown() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.airline_seat_recline_extra,
                color: kAccentColor,
              ),
              const SizedBox(width: 15.0),
              const CustomVerticalDivider(),
              const SizedBox(width: 10.0),
              DropdownButton<String>(
                icon: const Icon(null),
                underline: const SizedBox(),
                dropdownColor: kPrimaryColor,
                hint: const Text(
                  'CLASS',
                  style: TextStyle(
                    color: kActiveTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: _bookingClassList.map((String dropDownItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(
                      dropDownItem,
                      style: const TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    bookingClass = newValue;
                  });
                },
                value: bookingClass,
              )
            ],
          ),
        ),
        const CustomHorizontalDivider()
      ],
    );
  }

  bool checkNoSeatsAvailability(TicketData flight) {
    switch (bookingClass) {
      case 'Economy':
        return flight.economyClassSeatsList.length == 40;
      case 'Business':
        return flight.businessClassSeatsList.length == 40;
      case 'First':
        return flight.firstClassSeatsList.length == 40;
      default:
        return false;
    }
  }
}
