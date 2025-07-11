// lib/widgets/projects_section.dart
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.work_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Featured Projects',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildProjectCard(
                context,
                'E-Commerce App',
                'A complete shopping app with cart, payments, and user management.',
                ['Flutter', 'Firebase', 'Stripe'],
                'assets/images/project1.jpg',
              ),
              const SizedBox(height: 16),
              _buildProjectCard(
                context,
                'Weather App',
                'Beautiful weather app with location services and forecasts.',
                ['Flutter', 'APIs', 'Location'],
                'assets/images/project2.jpg',
              ),
              const SizedBox(height: 16),
              _buildProjectCard(
                context,
                'Task Manager',
                'Productivity app for managing daily tasks and projects.',
                ['Flutter', 'SQLite', 'Notifications'],
                'assets/images/project3.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String description,
    List<String> technologies,
    String imagePath,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: technologies
                      .map((tech) => _buildTechChip(context, tech))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(BuildContext context, String technology) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        technology,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
