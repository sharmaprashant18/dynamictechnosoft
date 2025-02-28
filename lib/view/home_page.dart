import 'dart:io';
import 'package:dynamictechnosoft/provider/switch_color_provider.dart';
import 'package:dynamictechnosoft/view/animated_text_view.dart';
import 'package:dynamictechnosoft/view/authentication_page.dart';
import 'package:dynamictechnosoft/view/child_page_for%20lock%20screen.dart';
import 'package:dynamictechnosoft/view/counter_view.dart';
import 'package:dynamictechnosoft/view/calendar&date_picker.dart';
import 'package:dynamictechnosoft/view/demo_hive.dart';
import 'package:dynamictechnosoft/view/firebase_page.dart';
import 'package:dynamictechnosoft/view/form_page.dart';
import 'package:dynamictechnosoft/view/heropage.dart';
import 'package:dynamictechnosoft/view/location_view.dart';
import 'package:dynamictechnosoft/view/movie_view.dart';
import 'package:dynamictechnosoft/view/shared_preferences.dart';
import 'package:dynamictechnosoft/view/single_ton_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  void closeApp() {
    exit(0);
  }

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Row(
            spacing: 10,
            children: [
              Text(
                isDarkMode ? "Enable Light Mode" : "Enable Dark Mode",
                style: TextStyle(fontSize: 16),
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) =>
                    ref.read(themeProvider.notifier).toogleTheme(),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure? You Want to Logout'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuthenticationPage(),
                                ));
                            // closeApp();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Logged Out Successful!',
                                  )),
                            );
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              ))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListView(
            children: [
              header(context, 0, 'Hive'),
              header(context, 1, 'Counter_ValueListanable'),
              header(context, 2, 'Date Converter'),
              header(context, 3, 'Shared Pereferences'),
              header(context, 4, 'Firebase Page'),
              header(context, 5, 'Google Map'),
              header(context, 6, ' Example of HeroPage'),
              header(context, 7, 'Movie'),
              header(context, 8, 'Animated Text'),
              header(context, 9, 'SingleTon'),
               header(context, 10, 'Form'),

              Row(
                children: [
                  Text(
                    isDarkMode ? "Light Mode" : "Dark Mode",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) =>
                        ref.read(themeProvider.notifier).toogleTheme(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: PermissionScreen(),
      ),
    );
  }

  Widget header(BuildContext context, int id, String title) {
    return ListTile(
      title: TextButton(
          onPressed: () {
            switch (id) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DemoHive()));

                break;
            }
            switch (id) {
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Counters(),
                    ));

                break;
            }
            switch (id) {
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarPages()));

                break;
            }
            switch (id) {
              case 3:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SharedPreferencesPage()));

                break;
            }
            switch (id) {
              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirebasePage()));

                break;
            }
            switch (id) {
              case 5:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocationView()));

                break;
            }
            switch (id) {
              case 6:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Heropagefirst()));

                break;
            }
            switch (id) {
              case 7:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieScreen()));

                break;
            }
            switch (id) {
              case 8:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnimationPage()));

                break;
            }
             switch (id) {
              case 9:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SingletonPattern()));

                break;
            }
                 switch (id) {
              case 10:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage()));

                break;
            }
          },
          child: Text(title)),
    );
  }
}
