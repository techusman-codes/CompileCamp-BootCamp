# 🧾 Receipt Booking App – *Analogy Restaurant Chain*

> A Flutter-based receipt booking and management system built for **Analogy**, a fictional restaurant chain.  
> Developed as **Project 3** in the [CompileCamp Bootcamp](https://github.com/techusman-codes/CompileCamp-BootCamp).

---

## 📸 Preview

![App Screenshot](https://github.com/techusman-codes/CompileCamp-BootCamp/blob/180b07fbfcac4ee4b70e0f28a2d8a6c3a31bbe14/Projects/Receipt_Book_app/Screenshot%20From%202025-08-02%2022-10-22.png)  
*Screenshots of receipt and booking screen will appear here once available.*

---

## 🍽️ Project Context

**Analogy** is a growing restaurant chain seeking a digital solution for handling customer bookings and generating receipts for dine-in and take-away services.

This mobile app aims to:

- Simplify table and order booking
- Automatically generate digital receipts
- Allow users to view and manage their bookings
- Enable staff to track customer service and generate reports

---

## ✨ Key Features

✅ Restaurant branding (Analogy logo, colors, etc.)  
✅ Table or order booking form  
✅ Receipt generator (with order details)  
✅ Booking list screen  
✅ Save/Share receipt (PDF – future)  
✅ Mobile-first UI design  
✅ Reusable and scalable Flutter widgets

---

## 🛠 Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: `setState` / (upgradable to Provider or Riverpod)
- **UI**: Material Design with a touch of custom theming for Analogy

---

## 🧑‍🍳 User Roles (Future Scope)

- **Customer**: Book table/order, receive receipt  
- **Waiter/Staff**: View daily bookings and receipts  
- **Admin**: Export daily/monthly reports, monitor activity

---

## 🧑‍💻 Getting Started

```bash
git clone https://github.com/techusman-codes/CompileCamp-BootCamp.git
cd CompileCamp-BootCamp/project_3_analogy_receipt_app
flutter pub get
flutter run

👨‍💻 Developer
Usman Umar Garba
https://www.linkedin.com/in/usman-umar-garba
https://x.com/dev_useee
https://github.com/techusman-codes



🏗️ Project Architecture

Folder Structure

lib/
├── main.dart
├── models/
│   ├── recipe.dart
│   ├── ingredient.dart
│   ├── nutrition_info.dart
│   └── user_preferences.dart
├── screens/
│   ├── home_screen.dart
│   ├── recipe_list_screen.dart
│   ├── recipe_detail_screen.dart
│   ├── favorites_screen.dart
│   ├── shopping_list_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── common/
│   │   ├── responsive_navigation.dart
│   │   ├── custom_app_bar.dart
│   │   └── loading_indicator.dart
│   ├── recipe/
│   │   ├── recipe_card.dart
│   │   ├── recipe_grid.dart
│   │   ├── ingredient_list.dart
│   │   └── instruction_steps.dart
│   └── search/
│       ├── search_bar.dart
│       └── filter_chips.dart
├── utils/
│   ├── responsive_breakpoints.dart
│   ├── route_generator.dart
│   ├── constants.dart
│   └── helpers.dart
└── data/
    ├── sample_recipes.dart
    └── recipe_categories.dart


B