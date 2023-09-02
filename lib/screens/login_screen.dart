import 'package:flight_reservation_app/utils/custom_text.dart';
import 'package:flight_reservation_app/utils/custom_textfields.dart';
import 'package:flight_reservation_app/utils/myAlert.dart';
import 'package:flight_reservation_app/constants.dart';
import 'package:flight_reservation_app/model/user_data.dart';
import 'package:flight_reservation_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextFieldController = TextEditingController();

  final _passwordTextFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 200),
              CustomTextFields(
                controller: _emailTextFieldController,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                title: 'E-MAIL',
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              const SizedBox(height: 40.0),
              CustomTextFields(
                controller: _passwordTextFieldController,
                icon: Icons.password,
                title: 'PASSWORD',
                obscureText: true,
                onChanged: (newValue) {
                  password = newValue;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                child: const CustomText(
                  text: 'Forget Password?',
                  color: kInactiveTextColor,
                ),
              ),
              const SizedBox(height: 15.0),
              ButtonTheme(
                height: 60.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    backgroundColor: kAccentColor,
                  ),
                  child:
                      const CustomText(text: 'Log in', color: kLoginTextColor),
                  onPressed: () {
                    if (email == null || password == null) {
                      MyAlert.errorAlert(context,
                          desc:
                              "One of the field is emplty. Fill all the fields");
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    Provider.of<UserData>(context, listen: false)
                        .setEmailAndPassword(email ?? '', password ?? '');
                    Navigator.pushNamed(context, MainScreen.id).then((value) {
                      _emailTextFieldController.clear();
                      _passwordTextFieldController.clear();
                    });
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CustomText(
                    text: 'Not a member?',
                    color: kInactiveTextColor,
                  ),
                  const SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Alert(
                          context: context,
                          title: "LOGIN",
                          style: const AlertStyle(
                            backgroundColor: kPrimaryColor,
                            titleStyle: TextStyle(
                              color: kAccentColor,
                            ),
                          ),
                          content: Column(
                            children: <Widget>[
                              CustomTextFields(
                                icon: Icons.account_circle,
                                title: 'EMAIL',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (newValue) {
                                  email = newValue;
                                },
                              ),
                              const SizedBox(height: 10.0),
                              CustomTextFields(
                                icon: Icons.lock,
                                title: 'PASSWORD',
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (newValue) {
                                  password = newValue;
                                },
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: kAccentColor,
                              onPressed: () {
                                if (email == null || password == null) {
                                  MyAlert.errorAlert(context,
                                      desc:
                                          "One of the field is emplty. Fill all the fields");
                                  return;
                                }
                                Provider.of<UserData>(context, listen: false)
                                    .setEmailAndPassword(
                                        email ?? '', password ?? '');
                                Navigator.pop(context);
                                Navigator.pushNamed(context, MainScreen.id);
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ]).show();
                    },
                    child: const CustomText(
                      text: 'Join now',
                      color: kAccentColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
