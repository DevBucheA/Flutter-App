import "package:flutter/material.dart";
import '../widgets/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/timer.dart';
import '../models/timermodel.dart';
import './settingScreen.dart';

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  TimerHomePage({super.key});

  void gotoSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
              onSelected: (s) {
                if (s == 'Settings') {
                  gotoSettings(context);
                }
              },
            )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: productivityButton(
                          color: Color(0xff009688),
                          text: "Work",
                          size: 30.0,
                          onPressed: () => timer.startWork())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: productivityButton(
                    color: Color(0xff607D8B),
                    text: "short Break",
                    size: 30.0,
                    onPressed: () => timer.startBreak(true),
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: productivityButton(
                    color: Color(0xff455A64),
                    text: "Long Break",
                    size: 30.0,
                    onPressed: () => timer.startBreak(false),
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              StreamBuilder(
                  initialData: "00:00",
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 20.0,
                        percent: timer.percent,
                        center: Text(timer.time,
                            style: Theme.of(context).textTheme.headline4),
                        progressColor: Color(0xff009688),
                      ),
                    );
                  }),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: productivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      size: 40.0,
                      onPressed: () => timer.StopTimer(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: productivityButton(
                        color: const Color(0xff009688),
                        text: 'Restart',
                        size: 40.0,
                        onPressed: () => timer.startTimer()),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  )
                ],
              )
            ],
          );
        }));
  }
}

void emptyMethod() {}
