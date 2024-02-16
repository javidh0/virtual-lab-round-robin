import 'package:flutter/material.dart';

double getWidth(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.width * percentage / 100;
}

double getHeight(double percentage, BuildContext context) {
  return MediaQuery.of(context).size.height * percentage / 100;
}
