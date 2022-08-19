import 'dart:ui';
import 'package:flutter/material.dart';

class Product{
  //members
  String group, url;
  Color primaryColor, textColor;
  //constructor
  Product({
    this.group ="yellow",
    this.url = "assets/products/yellow1.png",
    this.primaryColor = const Color(0xffffbf00),
    this.textColor = const Color(0xff1d1f20),
  });
}
