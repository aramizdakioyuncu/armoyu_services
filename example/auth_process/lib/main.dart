import 'package:auth_process/app/app.dart';
import 'package:auth_process/app/services/armoyu.dart';
import 'package:flutter/material.dart';

void main() {
  ARMOYU.service.setup();
  runApp(const MyApp());
}
