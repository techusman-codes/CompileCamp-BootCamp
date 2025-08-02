// data/recipe_categories.dart
import 'package:flutter/material.dart';
import '../models/category.dart';

const List<Category> recipeCategories = [
  Category(
    id: 'cat1',
    name: 'Breakfast',
    icon: Icons.free_breakfast,
    color: Colors.orangeAccent,
  ),
  Category(
    id: 'cat2',
    name: 'Lunch',
    icon: Icons.lunch_dining,
    color: Colors.greenAccent,
  ),
  Category(
    id: 'cat3',
    name: 'Dinner',
    icon: Icons.dinner_dining,
    color: Colors.blueAccent,
  ),
  Category(
    id: 'cat4',
    name: 'Snacks',
    icon: Icons.fastfood,
    color: Colors.pinkAccent,
  ),
];
