import 'package:flutter/material.dart';
import 'package:lecture9/app_data.dart';
import 'inherited_page.dart';


void main() {
  runApp(AppDataProvider(
    appData: AppData(backgroundColor: Colors.green),
    child: const MaterialApp(
      home: HomePage(),
    ),
  ));
}
