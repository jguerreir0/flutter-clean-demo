# 🧪 mydemo – Flutter Clean Architecture Demo

This is a demo Flutter project built with **Clean Architecture**, **BLoC state management**, **dependency injection (GetIt)**, and **unit testing**.

The goal is to demonstrate how to structure a scalable and maintainable Flutter app using best practices.

---

## 🧠 Stack & Architecture

- **State Management:** [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection:** [`get_it`](https://pub.dev/packages/get_it)
- **Clean Architecture:** Layered structure with `data`, `domain`, and `presentation`
- **API Layer:** Built using [`dio`](https://pub.dev/packages/dio)
- **Routing:** Centralized `AppRouter` with **custom fade transitions**
- **Authentication:** Login, logout, and session restore
- **Lottie Animations:** Reusable loader widget with `.splash()` and `.login()` factory constructors
- **Testing:** Unit and BLoC tests for use cases, repositories, and API layer

---

## ✨ Features

- [x] Splash screen with animated session check
- [x] Login with visual feedback (Lottie animation)
- [x] Logout with session cleanup
- [x] Product grid fetched from API
- [x] Custom **fade transition** between views using `PageRouteBuilder`
- [x] Dependency injection handled via `di.dart`
- [x] Routing through centralized `AppRouter`
- [x] Reusable Lottie widget with `.splash()` and `.login()` factories
- [x] Unit and bloc tests across all layers
- [x] Code formatted with `dart format`

---

## 📂 Project Structure

```
lib/
├── home/
│   ├── data/
│   │   ├── data_sources/
│   │   │   ├── abstract_product_api.dart
│   │   │   └── product_api_impl.dart
│   │   └── repositories/
│   │       └── product_repository_impl.dart
│   ├── domain/
│   │   ├── models/
│   │   │   └── product_model.dart
│   │   ├── repositories/
│   │   │   └── abstract_product_repository.dart
│   │   └── usecases/
│   │       └── products_use_case.dart
│   └── presentation/
│       ├── bloc/products_bloc/
│       │   ├── products_bloc.dart
│       │   ├── products_bloc_event.dart
│       │   └── products_bloc_state.dart
│       ├── home_page.dart
│       └── home.dart
│
├── login/
│   ├── data/
│   │   ├── data_sources/
│   │   │   ├── abstract_auth_api.dart
│   │   │   └── auth_api_impl.dart
│   │   └── repositories/
│   │       └── auth_repository_impl.dart
│   ├── domain/
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   ├── repositories/
│   │   │   └── abstract_auth_repository.dart
│   │   └── usecases/
│   │       └── login_use_case.dart
│   └── presentation/
│       ├── bloc/
│       ├── storage/
│       │   └── auth_storage.dart
│       ├── login_page.dart
│       └── login.dart
│
├── splash/
│   └── presentation/
│       └── splash_page.dart
│
├── utils/
│   ├── fade_route_transition/
│   │   └── fade_route_transition.dart
│   └── lottie_loader/
│       └── lottie_loader.dart
│
├── di.dart
├── main.dart
└── routes.dart

```

---

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

---

## 🧪 Running Tests

```bash
flutter test
```
---

## 💬 Final Notes

This project was built as a technical showcase and reflects:

- ✅ Clean and testable architecture  
- ✅ Separation of concerns and logic isolation  
- ✅ Scalable dependency injection  
- ✅ State management with BLoC  
- ✅ Custom route transitions (fade)  
- ✅ Lottie animations integrated into the auth flow  
- ✅ Readable and maintainable codebase
