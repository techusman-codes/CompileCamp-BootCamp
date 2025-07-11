// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileHeader(),
            SizedBox(height: 20),
            AboutSection(),
            SizedBox(height: 20),
            SkillsSection(),
            SizedBox(height: 20),
            ContactSection(),
            SizedBox(height: 20),
            ProfileSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
