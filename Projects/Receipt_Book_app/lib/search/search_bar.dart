// lib/widgets/search/search_bar.dart
import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const RecipeSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = 'Search recipes...',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
