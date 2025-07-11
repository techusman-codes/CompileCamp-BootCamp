// lib/main.dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme: AppTheme.lightTheme,
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
