// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController(text: "30");
    txtShort = TextEditingController(text: "5");
    txtLong = TextEditingController(text: "20");
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 24);
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Text("Work", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
            const Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
        TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingButton(const Color(0xff009688), "+", 1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
            const Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtShort,
            keyboardType: TextInputType.number),
        SettingButton(
            const Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
        Text(
          "Long",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        SettingButton(
            const Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtLong,
            keyboardType: TextInputType.number),
        SettingButton(
            const Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          workTime ??= 0; // If workTime is null, assign 0 to it
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs.getInt(SHORTBREAK);
          short ??= 0;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs.getInt(LONGBREAK);
          long ??= 0;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}