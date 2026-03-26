# 📱 Posts App - Clean Architecture

A Flutter application that fetches and displays posts, built with Clean Architecture principles and BLoC state management.

---

## 🏗️ Architecture

This project follows **Clean Architecture** with 3 main layers:
```
lib/
├── core/
│   
└── features/
    └── posts/
        ├── data/
        │   ├── datasources/
        │   ├── models/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        |   └── usecases/
        └── presentation/
            ├── bloc/
            ├── pages/
            └── widgets/
```

---

## 📦 Packages Used

| Package | Version | Purpose |
|--------|---------|---------|
| `flutter_bloc` | ^8.1.3 | State management |
| `flutter_screenutil` | ^5.9.0 | Responsive UI |
| `dio` | ^5.3.2 | HTTP requests |
| `get_it` | ^7.6.4 | Dependency injection |
| `equatable` | ^2.0.5 | Value equality |
| `dartz` | ^0.10.1 | Functional programming (Either) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Installation
```bash
# Clone the repository
https://github.com/Sohib-Emad/posts_app_clean_architecture.git

# Navigate to project
cd posts_app_clean_architecture

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---
## 🌿 Git Branches
```
main
└── feature/posts
```


## 📐 Clean Architecture Layers

### 1. Data Layer
- Fetches data from remote API (JSONPlaceholder)
- Contains models, datasources, and repository implementations

### 2. Domain Layer
- Contains business logic
- Defines entities, repository contracts, and use cases
- Independent of any framework

### 3. Presentation Layer
- UI widgets and pages
- BLoC for state management
- Fully responsive using `flutter_screenutil`

---

## 👨‍💻 Author

**Sohib Emad**
- GitHub: [@sohibemad](https://github.com/Sohib-Emad)
- Linkedin: [@sohibemad](https://www.linkedin.com/in/sohib-emad-3ba11a285/)

---

## 📄 License

This project is licensed under the MIT License.