import 'package:flutter/material.dart';

class productivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;
  const productivityButton(
      {super.key,
      required this.color,
      required this.text,
      required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      minWidth: size,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

typedef callbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;

  final String setting;
  final callbackSetting callback;

  const SettingButton(
      this.color, this.text, this.value, this.setting, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => callback(setting, value),
      color: this.color,
    );
  }
}
