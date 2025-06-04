import 'package:flutter/material.dart';
import 'package:militant_wrapper/initialization.dart';
import 'package:militant_wrapper/presentation/app/app.dart';

void main() async {
  await initializeApp();

  runApp(const App());
}
