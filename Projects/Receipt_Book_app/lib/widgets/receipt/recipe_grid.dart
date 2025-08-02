// widgets/recipe/recipe_grid.dart
import 'package:flutter/material.dart';
import 'package:receipt_app/models/reciept.dart';
import 'package:receipt_app/utils/responsive_breakpoints.dart';

class ResponsiveRecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final int maxItems;
  final void Function(String recipeId)? onTap;
  final void Function(String recipeId)? onFavorite;
  final bool Function(String recipeId)? isFavorite;
  final void Function(String recipeId)
  onAddToCart; // <-- Add this parameter with correct type

  const ResponsiveRecipeGrid({
    super.key,
    required this.recipes,
    required this.maxItems,
    this.onTap,
    this.onFavorite,
    this.isFavorite,
    required this.onAddToCart, // <-- Make it required and correct type
  });

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = ResponsiveBreakpoints.isMobile(context) ? 2 : 3;
    final displayRecipes = recipes.take(maxItems).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayRecipes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final recipe = displayRecipes[index];
        final bool fav = isFavorite?.call(recipe.id) ?? false;

        return GestureDetector(
          onTap: () => onTap?.call(recipe.id),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            fav ? Icons.favorite : Icons.favorite_border,
                            color: fav ? Colors.red : Colors.white,
                            size: 22,
                          ),
                          onPressed: () => onFavorite?.call(recipe.id),
                          tooltip: fav
                              ? 'Remove from favorites'
                              : 'Add to favorites',
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black.withAlpha(77),
                            padding: const EdgeInsets.all(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.totalTimeMinutes} min',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            recipe.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        runSpacing: -8,
                        children: [
                          if (recipe.isQuickMeal)
                            _buildTagChip(
                              context,
                              'Quick',
                              Icons.timer,
                              Colors.green[100]!,
                            ),
                          if (recipe.isVegetarian)
                            _buildTagChip(
                              context,
                              'Veg',
                              Icons.eco,
                              Colors.lightBlue[100]!,
                            ),
                          if (recipe.isVegan)
                            _buildTagChip(
                              context,
                              'Vegan',
                              Icons.local_florist,
                              Colors.purple[100]!,
                            ),
                        ],
                      ),

                      // <-- Add the button here:
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => onAddToCart(recipe.id),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Add to Cart'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagChip(
    BuildContext context,
    String label,
    IconData icon,
    Color bgColor,
  ) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, size: 14),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      labelStyle: Theme.of(context).textTheme.bodySmall,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: bgColor,
      visualDensity: VisualDensity.compact,
    );
  }
}
