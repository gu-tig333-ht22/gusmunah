import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/Component/component.dart';

InputDecoration decoration=InputDecoration(
  fillColor: HexColor("#F7F7FD"),
  filled: true,
  hoverColor: Colors.white60,
  hintStyle: TextStyle(
    fontWeight: FontWeight.normal,
    color: HexColor("#9699A9"),
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
        color: primaryColor,
        width: 0.2
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: primary_color_light,
      width: 0.2,
    ),
  ),
);
