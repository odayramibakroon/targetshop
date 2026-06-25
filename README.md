
# Target Shop - Flutter E-Commerce App

Target Shop is a modern Flutter e-commerce mobile application built with Clean Architecture and BLoC state management.
The app supports Arabic and English, dark mode and light mode, Firebase integration, authentication, categories, products, favorites, cart, profile image, and app settings.

## Features

* Login screen
* Register new account screen
* Home screen with product categories
* Categories loaded using StreamBuilder
* Products loaded by selected category using StreamBuilder
* Favorites page
* Shopping cart page
* Settings page
* Profile image support
* Arabic and English localization
* Dark mode and light mode
* System theme support
* Clean Architecture structure
* BLoC / Cubit state management
* Firebase backend integration
* Responsive Flutter UI

## Tech Stack

* Flutter
* Dart
* Firebase
* Firestore
* Firebase Authentication
* BLoC / Cubit
* Clean Architecture
* StreamBuilder
* Localization
* Theme Management

## Project Structure

```text
lib/
├── core/
├── features/
├── config/
├── generated/
└── main.dart
```

## Screens

* Login
* Register
* Home
* Categories
* Products
* Favorites
* Cart
* Settings
* Profile

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/odayramibakroon/targetshop.git
cd targetshop
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

## Firebase Setup

This project uses Firebase.
Before running the app, make sure you configure Firebase for your own project.

Recommended steps:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Then run:

```bash
flutter pub get
flutter run
```

## Keywords

Flutter E-Commerce App, Flutter Shop App, Flutter Store App, Clean Architecture Flutter, Flutter BLoC, Firebase E-Commerce, Arabic Flutter App, Multilingual Flutter App, Dark Mode Flutter App, Shopping Cart Flutter, Favorites Flutter App.

## Author

Developed by [Oday Rami Bakroon](https://github.com/odayramibakroon)
