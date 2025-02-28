import 'package:flutter/material.dart';

class MyThemeClass {
 static   ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
      //For AppBar
      appBarTheme: AppBarTheme(
          centerTitle: true,
          //This changes the background color of the appbar
          backgroundColor: Colors.red,
          //this is for the things used inside the action in appBar
          elevation: 100,
          actionsIconTheme: IconThemeData(color: Colors.amber),
          iconTheme: IconThemeData(
            color: Colors.cyan,
          )),
      //This changes the things of the elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: WidgetStatePropertyAll(10),
        foregroundColor: WidgetStatePropertyAll(Colors.red),
      )));

  //This is for the lightTheme
 static   ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          //this gives the elevation of the appBar
          actionsIconTheme: IconThemeData(color: Colors.greenAccent),
          elevation: 00,
          centerTitle: true,
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(color: Colors.blue)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(Colors.cyan),
              alignment: Alignment.center,
              elevation: WidgetStatePropertyAll(10),
              foregroundColor: WidgetStatePropertyAll(Colors.green),
              textStyle: WidgetStatePropertyAll(TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  decoration: TextDecoration.underline)),
              // Changes the background color of the elevated button
              // backgroundColor: WidgetStatePropertyAll(Colors.amberAccent)
              //changes the iconsize inside the button
              iconSize: WidgetStatePropertyAll(30))),
// This changest the things of the DatePicker /Calendar
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.amber,
        confirmButtonStyle: ButtonStyle(
          elevation: WidgetStatePropertyAll(100),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 100,
          backgroundColor: Colors.white,
          splashColor: Colors.red),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.red))));
}
