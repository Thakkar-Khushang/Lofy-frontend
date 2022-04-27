import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/address_input.dart';
import 'package:lofy_frontend/Screens/business_profile.dart';
import 'package:lofy_frontend/Screens/home_page.dart';
import 'package:lofy_frontend/utils/auth.utils.dart';
import 'package:lofy_frontend/utils/error.utils.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/navigator.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.userType}) : super(key: key);
  final userType;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggingIn = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 5,
                  offset: Offset(3, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset("assets/loginpeep.png"),
                Text(
                  isLoggingIn ? 'Log In' : 'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 25),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                fillColor: Color.fromARGB(255, 250, 250, 250),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      var body = {
                                        "email": _emailController.text,
                                        "password": _passwordController.text,
                                      };
                                      showLoader();
                                      var resp = await postUnauth(
                                          "${widget.userType == "Buyer" ? "customer" : "business"}/${isLoggingIn ? "login" : "signup"}",
                                          jsonEncode(body));
                                      showSnackBar(resp['message']);
                                      closeLoader();
                                      if (isLoggingIn) {
                                        await writeToken(resp['token']);
                                        await writeUserType(widget.userType);
                                        if (resp[widget.userType == "Seller"
                                                ? "business"
                                                : "customer"]['address'] ==
                                            null) {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddressInputScreen(
                                                      userType: widget.userType,
                                                    )),
                                          );
                                        } else {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => widget
                                                            .userType ==
                                                        "Buyer"
                                                    ? MyHomePage()
                                                    : BusinessProfileScreen()),
                                          );
                                        }
                                      }
                                    } on NotFoundException {
                                      showSnackBar("User not registered");
                                       if (!mounted) return;
                                      setState(() {
                                        isLoggingIn = false;
                                      });
                                      closeLoader();
                                    } catch (e) {
                                      closeLoader();
                                      showSnackBar(
                                          jsonDecode(e.toString())['message']);
                                      debugPrint(e.toString());
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.black,
                                  minimumSize: Size(screenSize.width * 0.5, 60),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                  ),
                                ),
                                child: Text(isLoggingIn ? "Log in" : "Sign up",
                                    style: TextStyle(fontSize: 20))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 15),
                  child: TextButton(
                      onPressed: () {
                         if (!mounted) return;
                        setState(() {
                          isLoggingIn = !isLoggingIn;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.black,
                        minimumSize: Size(screenSize.width * 0.5, 60),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                        ),
                      ),
                      child: Text(isLoggingIn ? "Sign up" : "Log in",
                          style: TextStyle(fontSize: 20))),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                      onPressed: () async {
                        if (_emailController.text.isNotEmpty ||
                            _emailController.text.trim() != "") {
                          showLoader();
                          try {
                            var resp = await postUnauth(
                                "${widget.userType == "Seller" ? "business" : "customer"}/send-email",
                                jsonEncode({
                                  "email": _emailController.text,
                                }));
                            showSnackBar(resp['message']);
                          } catch (e) {
                            showSnackBar("Something went wrong");
                            closeLoader();
                          }
                          closeLoader();
                        } else {
                          showSnackBar("The email field cannot be empty");
                        }
                      },
                      child: Text("Resend verification email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ))),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
