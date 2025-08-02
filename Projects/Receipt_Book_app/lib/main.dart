import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_app/providers/cart_provider.dart';
import 'package:receipt_app/screens/reeipt_list_scree.dart';
import 'widgets/common/responsive_navigation.dart';
import 'screens/home_screen.dart';
import 'package:receipt_app/screens/profile_screen.dart';
// ✅ Import the CartProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(), // ✅ Provide the cart state globally
      child: const ResponsiveRecipeBookApp(),
    ),
  );
}

class ResponsiveRecipeBookApp extends StatefulWidget {
  const ResponsiveRecipeBookApp({super.key});

  @override
  State<ResponsiveRecipeBookApp> createState() =>
      _ResponsiveRecipeBookAppState();
}

class _ResponsiveRecipeBookAppState extends State<ResponsiveRecipeBookApp> {
  Set<String> favoriteRecipeIds = {};

  void toggleFavorite(String recipeId) {
    setState(() {
      if (favoriteRecipeIds.contains(recipeId)) {
        favoriteRecipeIds.remove(recipeId);
      } else {
        favoriteRecipeIds.add(recipeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
      routes: {
        '/home': (context) => HomeScreen(
          favoriteRecipeIds: favoriteRecipeIds,
          onFavorite: toggleFavorite,
        ),
        '/recipes': (context) => RecipeListScreen(
          favoriteRecipeIds: favoriteRecipeIds,
          onFavorite: toggleFavorite,
        ),
        '/profile': (context) => const ProfileScreen(),
      },
      home: ResponsiveNavigation(
        favoriteRecipeIds: favoriteRecipeIds,
        onFavorite: toggleFavorite,
      ),
    );
  }
}
