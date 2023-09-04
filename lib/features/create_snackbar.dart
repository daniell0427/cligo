import 'package:flutter/material.dart';

void createSnackbar(context, message){
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(message);
}