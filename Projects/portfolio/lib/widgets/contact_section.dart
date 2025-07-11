// lib/widgets/contact_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
                    Icons.contact_mail,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Get in Touch',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildContactButton(
                      context,
                      'Email',
                      Icons.email,
                      () => _launchEmail(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildContactButton(
                      context,
                      'LinkedIn',
                      FontAwesomeIcons.linkedin,
                      () => _launchLinkedIn(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildContactButton(
                      context,
                      'GitHub',
                      FontAwesomeIcons.github,
                      () => _launchGitHub(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildContactButton(
                      context,
                      'Twitter',
                      FontAwesomeIcons.twitter,
                      () => _launchTwitter(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ugarba202@gmail.com.com',
      query: 'subject=Hello!',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchLinkedIn() async {
    const url = 'https://www.linkedin.com/in/usman-umar-garba/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _launchGitHub() async {
    const url = 'https://github.com/techusman-codes/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _launchTwitter() async {
    const url = 'https://x.com/dev_useee';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
