# Movies App

A Flutter movie app built for browsing movies, exploring details, and managing user account flows with Firebase-backed authentication and a modern dark UI.

## Overview

This project is a feature-based Flutter application that includes:

- onboarding / intro screen shown once for new users
- login, sign up, password reset, and profile update flows
- home screen with multiple tabs
- movie discovery and search experience
- movie details screen
- local persistence for intro state and cached movie data
- Firebase integration for app services

## Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Firebase Firestore
- BLoC / Cubit for state management
- Dio for networking
- SharedPreferences for local storage
- Hive for local cache storage
- Connectivity Plus
- Google Fonts and custom UI styling

## Project Structure

```text
movies_app/
├── android/
├── ios/
├── lib/
│   ├── core/
│   │   ├── cubit/
│   │   ├── services/
│   │   ├── utils/
│   │   └── widgets/
│   ├── features/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── movie_details/
│   │   └── on_boarding/
│   ├── main.dart
│   └── main_screen.dart
├── assets/
├── test/
├── firebase.json
├── firebase_options.dart
├── pubspec.yaml
├── analysis_options.yaml
├── STRUCTURE.md
└── README.md
```

## Features

### Authentication
- Login and registration screens
- Forgot password flow
- Profile editing
- User state stored and managed through app cubits

### Onboarding
- Intro screen shown once per first-time user
- Intro state persisted via `SharedPreferences`

### Movie Experience
- Home tab navigation
- Search functionality
- Movie detail viewing
- Poster-based movie browsing UI

### Offline / Local Data
- Local caching of movie data
- Shared preferences for intro flag and simple app state

## Getting Started

### Prerequisites

Make sure you have Flutter installed and configured on your machine.

- Flutter SDK
- Android Studio / Xcode for device emulators
- Firebase project configured for Flutter

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Firebase setup

This project already includes Firebase configuration files, but if you need to regenerate them:

```bash
flutterfire configure
```

Then run the app again.

## Useful Commands

```bash
flutter analyze
flutter test
flutter run
```

## Notes

- The app uses a dark theme by default.
- Intro visibility is controlled by `LocalStorageService.hasSeenIntro()` and `markIntroSeen()`.
- The app architecture follows a feature-first organization with reusable core utilities.

## License

This project is for educational/demo purposes and is not currently configured with a formal license.
