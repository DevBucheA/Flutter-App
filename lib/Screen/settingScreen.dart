import 'package:flutter/material.dart';
import 'settings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Setting'),
      ),
      body: Settings()
     
    );
  }
}