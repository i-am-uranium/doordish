import 'package:flutter/material.dart';

import 'constants/app_theme.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doordish',
      theme: AppTheme.theme,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
