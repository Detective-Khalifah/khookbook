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
  - Basic profile page with email verification.
  - Role-based access control (user/admin).
- **Personalization & Settings:**
  - **Theme Customization:** Choose between Light, Dark, or System default themes.
  - **Halal Filter:** Option to filter out recipes containing non-halal ingredients.
  - **Notification Toggle:** Enable or disable push notifications (UI toggle present).
  - **Language Selection:** UI for language preference (persisted).
- **Halal Verification System:**
  - Automatic ingredient screening for haram ingredients.
  - User reporting system for incorrect halal/haram classifications.
  - Admin verification workflow for reported recipes.
  - Halal verification statistics in user profiles.
- **Admin Dashboard:**
  - Review and manage halal verification reports.
  - Update recipe verification status.
  - View verification history and statistics.
  - Manage ingredient classification rules.

## Technologies Used

- **Flutter:** For cross-platform UI development.
- **Riverpod:** For state management.
- **Firebase:**
  - Firebase Authentication for user sign-up/sign-in.
  - Cloud Firestore for:
    - User profiles and roles
    - Halal verification records
    - User reports and admin actions
    - Verification statistics
- **Hive:** For local database caching of recipe data.
- **HTTP:** For network requests to TheMealDB API.
- **Key Packages:** `cached_network_image`, `youtube_player_flutter`, `flutter_svg`, `connectivity_plus`, `markdown_widget`, `animated_text_kit`.

## Project Structure

The project follows a feature-first approach for folder organization within the `lib` directory:

- `constants/`: Application-wide constants (e.g., colors, predefined ingredient lists).
- `data/`: Data repositories and sources.
- `middleware/`: Contains guards and middleware (e.g., AdminGuard for protected routes).
- `models/`:
  - Data models for recipes, categories, and user data
  - Hive cache models in `cache/` subdirectory
  - Verification-related models
- `pages/`:
  - Main recipe viewing and browsing pages
  - Admin dashboard and verification pages
  - User profile and settings pages
- `providers/`:
  - Riverpod providers for state management
  - Authentication and admin role providers
  - Halal verification providers
- `services/`:
  - Network fetching service
  - Halal verification service
  - Authentication service
- `utilities/`: Helper functions and utility classes
- `widgets/`:
  - Reusable UI components
  - Halal status indicators
  - YouTube player widget

## Admin Features

### Access Control
- Admin access is protected by `AdminGuard` middleware
- Admin status is managed through Firebase custom claims
- Secure route protection for admin-only pages

### Verification Dashboard
- Two-tab interface:
  1. **Pending Reports:** Review user-submitted halal verification reports
  2. **Verifications:** View and manage existing verifications
- Actions available:
  - Approve/reject user reports
  - Update verification status
  - Add verification notes
  - Track verification history

### Halal Verification System
- **Automatic Screening:**
  - Pre-defined lists of haram and suspect ingredients
  - Real-time ingredient checking
- **Manual Verification:**
  - Review user reports
  - Update verification status
  - Add notes and justification
- **Statistics Tracking:**
  - Total verifications
  - Halal/non-halal ratio
  - Pending reports count

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
