import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_app/data/sample_receipt.dart';
import 'package:receipt_app/models/nutrition_info.dart';
import 'package:receipt_app/models/reciept.dart';
import 'package:receipt_app/providers/cart_provider.dart';
import 'package:receipt_app/screens/receipe_detail_screen.dart';
import 'package:receipt_app/widgets/receipt/recipe_grid.dart';


class FavoritesScreen extends StatelessWidget {
  final Set<String> favoriteRecipeIds;
  final Function(String)? onFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoriteRecipeIds,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = SampleData.featuredRecipes
        .where((recipe) => favoriteRecipeIds.contains(recipe.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favoriteRecipes.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Favorites',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (favoriteRecipes.any((recipe) => recipe.isQuickMeal))
                        Chip(
                          label: const Text('Quick Meals'),
                          avatar: const Icon(Icons.timer, size: 18),
                          backgroundColor: Colors.green[100],
                        ),
                      if (favoriteRecipes.any((recipe) => recipe.isVegetarian))
                        Chip(
                          label: const Text('Vegetarian'),
                          avatar: const Icon(Icons.eco, size: 18),
                          backgroundColor: Colors.blue[100],
                        ),
                      if (favoriteRecipes.any((recipe) => recipe.isVegan))
                        Chip(
                          label: const Text('Vegan'),
                          avatar: const Icon(Icons.local_florist, size: 18),
                          backgroundColor: Colors.purple[100],
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ResponsiveRecipeGrid(
                      recipes: favoriteRecipes,
                      maxItems: favoriteRecipes.length,
                      onFavorite: onFavorite,
                      isFavorite: (recipeId) =>
                          favoriteRecipeIds.contains(recipeId),
                      onTap: (recipeId) {
                        final recipe = SampleData.featuredRecipes.firstWhere(
                          (recipe) => recipe.id == recipeId,
                          orElse: () => Recipe(
                            id: '',
                            title: 'Unknown Recipe',
                            description: 'No description available',
                            imageUrl: '',
                            additionalImages: [],
                            cookTimeMinutes: 0,
                            prepTimeMinutes: 0,
                            servings: 0,
                            difficulty: 'easy',
                            ingredients: [],
                            instructions: [],
                            tags: [],
                            nutritionInfo: NutritionInfo(
                              calories: 0,
                              fat: 0,
                              protein: 0,
                              carbs: 0,
                              fiber: 0,
                              sugar: 0,
                              sodium: 0,
                            ),
                            rating: 0,
                            reviewCount: 0,
                            category: '',
                            createdAt: DateTime.now(),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                      onAddToCart: (recipeId) {
                        final cartProvider = context
                            .read<CartProvider>(); // 🛒 Add this line

                        final recipe = favoriteRecipes.firstWhere(
                          (r) => r.id == recipeId,
                          orElse: () => Recipe(
                            id: recipeId,
                            title: 'Unknown',
                            description: '',
                            imageUrl: '',
                            additionalImages: [],
                            cookTimeMinutes: 0,
                            prepTimeMinutes: 0,
                            servings: 0,
                            difficulty: '',
                            ingredients: [],
                            instructions: [],
                            tags: [],
                            nutritionInfo: NutritionInfo(
                              calories: 0,
                              fat: 0,
                              protein: 0,
                              carbs: 0,
                              fiber: 0,
                              sugar: 0,
                              sodium: 0,
                            ),
                            rating: 0,
                            reviewCount: 0,
                            category: '',
                            createdAt: DateTime.now(),
                          ),
                        );

                        cartProvider.addToCart(recipe.id); // ✅ Add to cart

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${recipe.title} added to cart'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: Text('No favorite recipes yet.')),
      ),
    );
  }
}
