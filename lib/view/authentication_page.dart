import 'dart:io';
import 'package:dynamictechnosoft/view/home_page.dart';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  void closeApp() {
    exit(0);
  }

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool? checkAuthentication;
  bool isAuthenticated = false;
  Future<void> checkBiometrics() async {
    try {
      checkAuthentication = await localAuthentication.canCheckBiometrics;
      setState(() {});
    } catch (e) {
      throw Exception('Error:$e');
    }
  }

  Future<void> authenticatedBiometrics() async {
    try {
      bool authenticated = await localAuthentication.authenticate(
          localizedReason: 'Authenticate to log in',
          options:
              AuthenticationOptions(stickyAuth: true, useErrorDialogs: true));
      setState(() {
        isAuthenticated = authenticated;
      });
      if (authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Logged in Successfully'),
          backgroundColor: Colors.green,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Authentication Failed'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      throw Exception('Authentication Failed:$e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication Page"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color(0xffEDEBE3),
                    content: Text('Do you want to leave app?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.green),
                          )),
                      TextButton(
                          onPressed: closeApp,
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.green),
                          ))
                    ],
                  ),
                );
              },
              label: Text('Exit'))
        ],
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (checkAuthentication == true)
                Column(
                  children: [
                    Text('Please Do Authentication.'),
                    TextButton(
                        onPressed: authenticatedBiometrics,
                        child: Icon(
                          Icons.fingerprint_outlined,
                          size: 70,
                        )),
                  ],
                ),
              if (checkAuthentication == false)
                Text(
                  'Biometrics is not available in this device',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
