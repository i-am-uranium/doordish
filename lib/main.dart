import 'package:flutter/material.dart';

import 'features/agent/assistant_workspace.dart';
import 'features/agent/mock_ordering_agent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF23B26D),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Doordish',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F2),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
      ),
      home: AssistantWorkspace(agent: MockOrderingAgent()),
      debugShowCheckedModeBanner: false,
    );
  }
}
