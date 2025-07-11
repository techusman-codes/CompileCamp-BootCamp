// lib/widgets/about_section.dart
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'About Me',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Experienced and dedicated Mobile Engineer specializing in developing high-quality, cross-platform mobile and web applications using the Flutter framework. Passionate about creating immersive and user-centered experiences, w efficient, and seamless applications.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInterestChip(context, 'Mobile App Development'),
                  _buildInterestChip(context, 'UI/UX Design'),
                  _buildInterestChip(context, 'Problem Solving'),
                  _buildInterestChip(context, 'Learning'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
