import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_app/data/sample_receipt.dart';
import 'package:receipt_app/models/nutrition_info.dart';
import 'package:receipt_app/models/reciept.dart';
import 'package:receipt_app/providers/cart_provider.dart';


class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.cartItems.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear all',
              onPressed: () => cartProvider.clearCart(),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final recipeId = cartItems[index];
                final recipe = SampleData.featuredRecipes.firstWhere(
                  (r) => r.id == recipeId,
                  orElse: () => Recipe(
                    id: recipeId,
                    title: 'Unknown Recipe',
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

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: recipe.imageUrl.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(recipe.imageUrl),
                          )
                        : const CircleAvatar(child: Icon(Icons.fastfood)),
                    title: Text(recipe.title),
                    subtitle: Text(recipe.category),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => cartProvider.removeFromCart(recipeId),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
