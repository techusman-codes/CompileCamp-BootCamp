import 'package:flutter/material.dart';
import 'package:receipt_app/data/sample_receipt.dart';
import 'package:receipt_app/models/nutrition_info.dart';
import 'package:receipt_app/models/reciept.dart';
import 'package:receipt_app/screens/receipe_detail_screen.dart';
import 'package:receipt_app/utils/responsive_breakpoints.dart';
import 'package:receipt_app/widgets/receipt/recipe_grid.dart';

class HomeScreen extends StatefulWidget {
  final Set<String> favoriteRecipeIds;
  final Function(String) onFavorite;

  const HomeScreen({
    super.key,
    required this.favoriteRecipeIds,
    required this.onFavorite,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 32),
            _buildFeaturedRecipes(context),
            const SizedBox(height: 32),
            _buildQuickCategories(context),
            const SizedBox(height: 32),
            if (_selectedCategory != null) _buildCategoryRecipes(context),
            const SizedBox(height: 32),
            _buildRecentlyViewed(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Recipe Book'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearch(context),
          tooltip: 'Search Recipes',
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () => _navigateToFavorites(context),
          tooltip: 'View Favorites',
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => _navigateToShoppingList(context),
          tooltip: 'Shopping List',
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 200 : 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Recipe Book',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover amazing recipes for every occasion',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withAlpha((0.9 * 255).toInt()),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _exploreRecipes(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[600],
              ),
              child: const Text('Explore Recipes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Recipes',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ResponsiveRecipeGrid(
          recipes: SampleData.featuredRecipes,
          maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
          onFavorite: widget.onFavorite,
          isFavorite: (recipeId) => widget.favoriteRecipeIds.contains(recipeId),
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

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${recipe.title} added to cart')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Categories',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildCategoryChip('Breakfast', Icons.free_breakfast),
            _buildCategoryChip('Lunch', Icons.lunch_dining),
            _buildCategoryChip('Dinner', Icons.dinner_dining),
            _buildCategoryChip('Snacks', Icons.fastfood),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    final isSelected = _selectedCategory == label;
    return ActionChip(
      avatar: Icon(icon, size: 18, color: isSelected ? Colors.white : null),
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : null),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      backgroundColor: isSelected ? Colors.orange[600] : null,
      onPressed: () {
        setState(() {
          _selectedCategory = _selectedCategory == label ? null : label;
        });
      },
    );
  }

  Widget _buildCategoryRecipes(BuildContext context) {
    final List<Recipe> categoryRecipes = SampleData.featuredRecipes
        .where(
          (recipe) =>
              recipe.category.toLowerCase() == _selectedCategory!.toLowerCase(),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$_selectedCategory Recipes',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        categoryRecipes.isNotEmpty
            ? ResponsiveRecipeGrid(
                recipes: categoryRecipes,
                maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
                onFavorite: widget.onFavorite,
                isFavorite: (recipeId) =>
                    widget.favoriteRecipeIds.contains(recipeId),
                onTap: (recipeId) => _navigateToRecipeDetail(context, recipeId),
                onAddToCart: (recipeId) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Recipe $recipeId added to cart')),
                  );
                },
              )
            : const Text('No recipes found for this category.'),
      ],
    );
  }

  Widget _buildRecentlyViewed(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Viewed',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('No recently viewed items yet.'), // Placeholder
      ],
    );
  }

  // Helper methods
  void _showSearch(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality not implemented yet')),
    );
  }

  void _navigateToShoppingList(BuildContext context) {
    Navigator.pushNamed(context, '/shopping');
  }

  void _navigateToFavorites(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to Favorites using the navigation bar'),
      ),
    );
  }

  void _exploreRecipes(BuildContext context) {
    _viewAllRecipes(context);
  }

  void _viewAllRecipes(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All recipes view not implemented yet')),
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
