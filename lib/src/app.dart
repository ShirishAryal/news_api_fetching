// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './screens/home_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'News',
      home: HomeScreen(),
    );
  }
}
