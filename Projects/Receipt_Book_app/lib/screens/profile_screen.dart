import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar & Name
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/avatar.png',
                    ), // replace or use NetworkImage
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Usman Umar Garba',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Chief Uceee',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Cooking Preferences
            _buildSectionTitle(context, 'Cooking Preferences'),
            const SizedBox(height: 8),
            _buildPreferencesChips([
              'Quick Meals',
              'Vegetarian',
              'Grilling',
              'Air Fryer',
              'Baking',
            ]),

            const SizedBox(height: 24),

            // Dietary Restrictions
            _buildSectionTitle(context, 'Dietary Restrictions'),
            const SizedBox(height: 8),
            _buildPreferencesChips([
              'No Dairy',
              'Low Sodium',
              'Gluten-Free',
              'Nut-Free',
            ]),

            const SizedBox(height: 24),

            // Recipe Statistics
            _buildSectionTitle(context, 'Recipe Statistics'),
            const SizedBox(height: 8),
            _buildStatsRow([
              _buildStatCard(Icons.favorite, 'Favorites', '12'),
              _buildStatCard(Icons.history, 'Viewed', '37'),
              _buildStatCard(Icons.bookmark, 'Saved', '8'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPreferencesChips(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: items
          .map(
            (item) => Chip(
              label: Text(item),
              backgroundColor: Colors.orange.shade100,
              avatar: const Icon(Icons.check, size: 16),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatsRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28, color: Colors.orange[600]),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
