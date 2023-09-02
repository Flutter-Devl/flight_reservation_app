// ignore_for_file: invalid_use_of_visible_for_testing_member, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flight_reservation_app/utils/custom_textfields.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameTFController = TextEditingController();
  final _emailTFController = TextEditingController();
  final _passwordTFController = TextEditingController();
  String? username;
  String? email;
  String? password;
  bool showSpinner = false;
  bool isChanged = false;

  @override
  void dispose() {
    super.dispose();
    _usernameTFController.dispose();
    _emailTFController.dispose();
    _passwordTFController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    _usernameTFController.text = user.username;
    _emailTFController.text = user.email ?? '';
    _passwordTFController.text = user.password ?? '';
    username = user.username;
    email = user.email;
    password = user.password;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        color: kPrimaryColor,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 100),
              const Center(
                  child: Text(
                'USER PROFILE',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              const SizedBox(height: 100),
              CustomTextFields(
                icon: Icons.account_circle,
                title: 'USERNAME',
                controller: _usernameTFController,
                onChanged: (newValue) {
                  username = newValue;
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFields(
                icon: Icons.alternate_email,
                title: 'EMAIL',
                controller: _emailTFController,
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFields(
                icon: Icons.lock,
                obscureText: true,
                title: 'PASSWORD',
                controller: _passwordTFController,
                onChanged: (newValue) {
                  password = newValue;
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(color: kPrimaryColor)),
                  child: const Text('SAVE CHANGES'),
                  onPressed: () {
                    user.saveProfileChanges(
                        username: username ?? '',
                        email: email ?? '',
                        password: password ?? '');
                    setState(() {
                      showSpinner = true;
                    });

                    Timer(const Duration(seconds: 2), () {
                      setState(() {
                        showSpinner = false;
                        Navigator.of(context).pop();
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
