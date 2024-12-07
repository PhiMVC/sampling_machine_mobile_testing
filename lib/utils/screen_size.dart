import 'package:flutter/material.dart';

double width = 0;
double height = 0;

Widget heightDivide(double value) => SizedBox(
      height: height / value,
    );
Widget widthDivide(double value) => SizedBox(
      width: width / value,
    );
double widthSize(double value) => width / value;
double heightSize(double value) => height / value;
