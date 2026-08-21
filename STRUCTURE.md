# Project Architecture

The project follows a **Feature-First Architecture** with **MVVM** and **BLoC/Cubit**.

The project is organized into two main sections:

```text
lib/
├── core/
└── features/
```

---

# Core

The `core` folder contains shared resources that can be used across different features.

```text
core/
├── cache/
├── network/
├── localization/
├── utils/
└── widgets/
```

### cache/

Contains shared caching and local storage utilities.

### network/

Contains the API client and network-related utilities.

### localization/

Contains localization-related state management such as the `LocalizationCubit`.

### utils/

Contains common utilities and helper functions.

### widgets/

Contains reusable widgets shared across multiple features.

---

# Features

All application features are located inside the `features` folder.

Each feature follows this structure:

```text
feature/
├── model/
├── views/
├── viewmodels/
└── widgets/
```

### model/

Contains the models related to the feature.

### views/

Contains the screens and UI of the feature.

### viewmodels/

Contains the BLoC/Cubit responsible for the feature's state management.

### widgets/

Contains reusable widgets specific to the feature.

---

# Authentication Feature

The authentication feature is divided into separate sub-features:

```text
auth/
├── login/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── register/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── forget_password/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
└── update_profile/
    ├── model/
    ├── views/
    ├── viewmodels/
    └── widgets/
```

Each authentication operation is treated as an independent sub-feature.

---

# Home Feature

The Home feature contains the application's main tabs:

```text
home/
├── home_tab/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── search_tab/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── browse_tab/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
└── profile_tab/
    ├── model/
    ├── views/
    ├── viewmodels/
    └── widgets/
```

Each tab is treated as an independent sub-feature.

---

# Main Features Structure

The overall features structure is:

```text
features/
├── splash/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── onboarding/
│   ├── model/
│   ├── views/
│   ├── viewmodels/
│   └── widgets/
│
├── auth/
│   ├── login/
│   ├── register/
│   ├── forget_password/
│   └── update_profile/
│
├── home/
│   ├── home_tab/
│   ├── search_tab/
│   ├── browse_tab/
│   └── profile_tab/
│
└── movie_details/
    ├── model/
    ├── views/
    ├── viewmodels/
    └── widgets/
```

---

# Final Structure

```text
lib/
│
├── core/
│   ├── cache/
│   ├── network/
│   ├── localization/
│   ├── utils/
│   └── widgets/
│
└── features/
    │
    ├── splash/
    │   ├── model/
    │   ├── views/
    │   ├── viewmodels/
    │   └── widgets/
    │
    ├── onboarding/
    │   ├── model/
    │   ├── views/
    │   ├── viewmodels/
    │   └── widgets/
    │
    ├── auth/
    │   ├── login/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   ├── register/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   ├── forget_password/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   └── update_profile/
    │       ├── model/
    │       ├── views/
    │       ├── viewmodels/
    │       └── widgets/
    │
    ├── home/
    │   ├── home_tab/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   ├── search_tab/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   ├── browse_tab/
    │   │   ├── model/
    │   │   ├── views/
    │   │   ├── viewmodels/
    │   │   └── widgets/
    │   │
    │   └── profile_tab/
    │       ├── model/
    │       ├── views/
    │       ├── viewmodels/
    │       └── widgets/
    │
    └── movie_details/
        ├── model/
        ├── views/
        ├── viewmodels/
        └── widgets/
```
