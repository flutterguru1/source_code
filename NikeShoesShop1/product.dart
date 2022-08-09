import 'dart:ui';
import 'package:flutter/material.dart';

//model class
class Product{
  //members
  String url;
  Color primaryColor, textColor;

  Product({this.url = "assets/products/yellow1.png", this.primaryColor = const Color(0xffffbf00), this.textColor = const Color(0xff1d1f20)});
}
