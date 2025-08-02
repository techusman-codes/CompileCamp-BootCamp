import 'package:flutter/material.dart';
import 'package:receipt_app/screens/favorite_screens.dart';
import 'package:receipt_app/screens/home_screen.dart';
import 'package:receipt_app/screens/profile_screen.dart';
import 'package:receipt_app/screens/reeipt_list_scree.dart';
import 'package:receipt_app/screens/shopping_list_screen.dart';
import 'package:receipt_app/utils/responsive_breakpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ResponsiveNavigation extends StatefulWidget {
  const ResponsiveNavigation({
    super.key,
    required Set<String> favoriteRecipeIds,
    required void Function(String recipeId) onFavorite,
  });

  @override
  ResponsiveNavigationState createState() => ResponsiveNavigationState();
}

class ResponsiveNavigationState extends State<ResponsiveNavigation> {
  int selectedIndex = 0;
  Set<String> favoriteRecipeIds = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteRecipeIds = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteRecipeIds.contains(recipeId)) {
        favoriteRecipeIds.remove(recipeId);
      } else {
        favoriteRecipeIds.add(recipeId);
      }
      prefs.setStringList('favorites', favoriteRecipeIds.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<NavItem> destinations = [
      NavItem(
        label: 'Home',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        page: HomeScreen(
          favoriteRecipeIds: favoriteRecipeIds,
          onFavorite: _toggleFavorite,
        ),
      ),
      NavItem(
        label: 'Recipes',
        icon: Icons.restaurant_outlined,
        selectedIcon: Icons.restaurant,
        page: RecipeListScreen(
          favoriteRecipeIds: favoriteRecipeIds,
          onFavorite: _toggleFavorite,
        ),
      ),
      NavItem(
        label: 'Favorites',
        icon: Icons.favorite_outline,
        selectedIcon: Icons.favorite,
        page: FavoritesScreen(
          favoriteRecipeIds: favoriteRecipeIds,
          onFavorite: _toggleFavorite,
        ),
      ),
      const NavItem(
        label: 'Profile',
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        page: ProfileScreen(),
      ),
      const NavItem(
        label: 'Shopping',
        icon: Icons.shopping_cart_outlined,
        selectedIcon: Icons.shopping_cart,
        page: ShoppingListScreen(),
      ),
    ];

    if (ResponsiveBreakpoints.isDesktop(context)) {
      return _buildDesktopLayout(destinations);
    } else if (ResponsiveBreakpoints.isTablet(context)) {
      return _buildTabletLayout(destinations);
    } else {
      return _buildMobileLayout(destinations);
    }
  }

  Widget _buildDesktopLayout(List<NavItem> destinations) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations
                .map(
                  (dest) => NavigationRailDestination(
                    icon: Icon(dest.icon),
                    selectedIcon: Icon(dest.selectedIcon),
                    label: Text(dest.label),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: destinations[selectedIndex].page),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(List<NavItem> destinations) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations
                .map(
                  (dest) => NavigationRailDestination(
                    icon: Icon(dest.icon),
                    selectedIcon: Icon(dest.selectedIcon),
                    label: Text(dest.label),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: destinations[selectedIndex].page),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(List<NavItem> destinations) {
    return Scaffold(
      body: destinations[selectedIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations
            .map(
              (dest) => NavigationDestination(
                icon: Icon(dest.icon),
                selectedIcon: Icon(dest.selectedIcon),
                label: dest.label,
              ),
            )
            .toList(),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
