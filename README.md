# khookbook

Khookbook is a Flutter-based mobile application designed to help users discover, view, and manage food recipes. It features online recipe fetching with offline caching, user authentication, and personalized settings.

## Features

- **Recipe Discovery:**
  - Browse recipes by categories.
  - View detailed meal information including ingredients, measures, instructions, and origin.
  - Watch embedded YouTube cooking videos with a floating player.
- **Offline Access:**
  - Recipes and categories are cached locally using Hive for offline availability.
- **User Accounts:**
  - Sign up and sign in functionality using Firebase Authentication.
  - Basic profile page.
- **Personalization & Settings:**
  - **Theme Customization:** Choose between Light, Dark, or System default themes.
  - **Halal Filter:** Option to filter out recipes containing non-halal ingredients.
  - **Notification Toggle:** Enable or disable push notifications (UI toggle present).
  - **Language Selection:** UI for language preference (persisted).

## Technologies Used

- **Flutter:** For cross-platform UI development.
- **Riverpod:** For state management.
- **Firebase:**
  - Firebase Authentication for user sign-up/sign-in.
  - Firestore (for potential future use like user-specific data or halal verification records).
- **Hive:** For local database caching of recipe data.
- **HTTP:** For network requests to TheMealDB API.
- **Key Packages:** `cached_network_image`, `youtube_player_flutter`, `flutter_svg`, `connectivity_plus`, `markdown_widget`, `animated_text_kit`.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

To run this project:
1. Ensure you have Flutter installed.
2. Clone the repository.
3. Set up a Firebase project and add your `firebase_options.dart` (or configure for your platform).
4. Run `flutter pub get` to install dependencies.
5. Run `flutter run` to launch the application.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Folder Structure

The project follows a feature-first approach for folder organization within the `lib` directory:

- `constants/`: Application-wide constants (e.g., colors).
- `data/`: Data repositories and sources.
- `models/`: Data models, including Hive cache models in a `cache/` subdirectory.
- `pages/`: UI widgets representing different screens/pages.
- `providers/`: Riverpod providers for state management.
- `services/`: Business logic services (e.g., network fetching).
<!-- - `theme/`: Application theming. -->
- `utilities/`: Helper functions and utility classes.
- `widgets/`: Reusable UI components.
