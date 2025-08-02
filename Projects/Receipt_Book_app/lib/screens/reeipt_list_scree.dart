import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_app/data/sample_receipt.dart';
import 'package:receipt_app/models/nutrition_info.dart';
import 'package:receipt_app/models/reciept.dart' show Recipe;
import 'package:receipt_app/providers/cart_provider.dart';
import 'package:receipt_app/screens/receipe_detail_screen.dart';
import 'package:receipt_app/utils/responsive_breakpoints.dart';
import 'package:receipt_app/widgets/receipt/recipe_grid.dart';


class RecipeListScreen extends StatelessWidget {
  final Set<String> favoriteRecipeIds;
  final Function(String) onFavorite;

  const RecipeListScreen({
    super.key,
    required this.favoriteRecipeIds,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Recipes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'All Recipes',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ResponsiveRecipeGrid(
              recipes: SampleData.featuredRecipes,
              maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
              onFavorite: onFavorite,
              isFavorite: (recipeId) => favoriteRecipeIds.contains(recipeId),
              onTap: (recipeId) => _navigateToRecipeDetail(context, recipeId),
              onAddToCart: (recipeId) {
                final recipe = SampleData.featuredRecipes.firstWhere(
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

                // ✅ Add to cart using CartProvider
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addToCart(recipe.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${recipe.title} added to cart')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRecipeDetail(BuildContext context, String recipeId) {
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
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }
}
