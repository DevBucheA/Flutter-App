import 'package:flutter/material.dart';
import 'Screen/TimerHomePage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'models/timer.dart';

void main() {
  runApp( TimerMain());
}


class TimerMain extends StatelessWidget {
  
  TimerMain({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'My work Timer', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey
      ),
      home:TimerHomePage(),
        );
  }
}

void emptyMethod() {}
