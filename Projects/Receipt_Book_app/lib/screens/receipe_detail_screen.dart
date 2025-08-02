import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_app/models/nutrition_info.dart';
import 'package:receipt_app/models/reciept.dart';
import 'package:receipt_app/providers/cart_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isInCart = cartProvider.isInCart(recipe.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: Icon(isInCart ? Icons.check_circle : Icons.add_shopping_cart),
            tooltip: isInCart ? 'Already in cart' : 'Add to cart',
            onPressed: isInCart
                ? null
                : () {
                    cartProvider.addToCart(recipe.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${recipe.title} added to cart')),
                    );
                  },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              recipe.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Quick facts
            LayoutBuilder(
              builder: (context, constraints) {
                double maxItemWidth = (constraints.maxWidth - 32) / 2;
                if (constraints.maxWidth > 600) {
                  maxItemWidth = (constraints.maxWidth - 48) / 3;
                }

                return Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildIconText(
                      Icons.timer,
                      '${recipe.cookTimeMinutes + recipe.prepTimeMinutes} min',
                      maxItemWidth,
                    ),
                    _buildIconText(
                      Icons.restaurant,
                      '${recipe.servings} servings',
                      maxItemWidth,
                    ),
                    _buildIconText(
                      Icons.local_fire_department,
                      '${recipe.nutritionInfo.calories} kcal',
                      maxItemWidth,
                    ),
                    _buildIconText(
                      Icons.star,
                      '${recipe.rating} (${recipe.reviewCount} reviews)',
                      maxItemWidth,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // Ingredients
            Text(
              'Ingredients',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('• $ingredient'),
              ),
            ),

            const SizedBox(height: 24),

            // Instructions
            Text(
              'Instructions',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.instructions.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('${entry.key + 1}. ${entry.value}'),
              ),
            ),

            const SizedBox(height: 24),

            // Nutrition Info
            Text(
              'Nutrition Info',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildNutritionInfo(recipe.nutritionInfo),

            const SizedBox(height: 24),

            // ✅ Add to Cart Button (extra)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                onPressed: isInCart
                    ? null
                    : () {
                        cartProvider.addToCart(recipe.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${recipe.title} added to cart'),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: isInCart ? Colors.grey : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, double maxWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(NutritionInfo nutrition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fat: ${nutrition.fat}g'),
        Text('Protein: ${nutrition.protein}g'),
        Text('Carbs: ${nutrition.carbs}g'),
        Text('Fiber: ${nutrition.fiber}g'),
        Text('Sugar: ${nutrition.sugar}g'),
        Text('Sodium: ${nutrition.sodium}mg'),
      ],
    );
  }
}
