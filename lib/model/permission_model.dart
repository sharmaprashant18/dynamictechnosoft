import 'package:flutter/material.dart';

class CustomPermission {
  final bool status;
  final Color color;
  final Color textColor;
  final String title;

  CustomPermission({
    required this.status,
    required this.color,
    required this.textColor,
    required this.title,
  });

  CustomPermission copyWith({
    bool? status,
    Color? color,
    Color? textColor,
    String? title,
  }) {
    return CustomPermission(
      status: status ?? this.status,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      title: title ?? this.title,
    );
  }

  static List<CustomPermission> listOfPermissions = [
    CustomPermission(
      status: false,
      color: Colors.lightGreen,
      textColor: Colors.green,
      title: 'Camera Permission',
    ),
    CustomPermission(
      status: false,
      color: Colors.lightBlue,
      textColor: Colors.blue,
      title: 'Gps Permission',
    ),
    CustomPermission(
      status: false,
      color: Colors.orange,
      textColor: Colors.white,
      title: 'Location Permission',
    )
  ];
}