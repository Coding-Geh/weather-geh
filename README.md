# WeatherGeh 🌤️

A beautiful and modern weather forecast app built with Flutter.

![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## Features

- 🌡️ Real-time weather data
- 📍 GPS location detection
- 🔍 City search
- 📊 Hourly & daily forecast
- 🌙 Dark/Light mode
- 🌐 Multi-language (English & Bahasa Indonesia)
- 💨 Wind, humidity, pressure, visibility info
- 🌅 Sunrise & sunset times

## Screenshots

*Coming soon*

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.7+)
- [OpenWeatherMap API Key](https://openweathermap.org/api) (Free tier available)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/Coding-Geh/weather-geh.git
cd weather-geh
```

### 2. Setup environment variables

Create a `.env` file in the root directory:

```bash
cp .env.example .env
```

Edit `.env` and add your OpenWeatherMap API key:

```env
OPENWEATHER_API_KEY=your_api_key_here
```

> 💡 Get your free API key at [openweathermap.org](https://openweathermap.org/api)

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Generate code

Run build_runner to generate required files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the app

```bash
flutter run
```

## Build for Production

### Android

```bash
flutter build apk --release
```

APK will be at `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Project Structure

```
lib/
├── core/
│   ├── config/       # Environment configuration
│   ├── constants/    # App & API constants
│   ├── theme/        # App theming
│   └── utils/        # Utility helpers
├── models/           # Data models (Freezed)
├── services/         # API & location services
├── viewmodels/       # State management (Riverpod)
└── views/
    ├── widgets/      # Reusable widgets
    └── screens       # App screens
```

## Tech Stack

- **State Management**: Riverpod
- **API Client**: Dio
- **Code Generation**: Freezed, JSON Serializable
- **Localization**: Easy Localization
- **Location**: Geolocator
- **Environment**: Envied

## Contributing

Pull requests are welcome! For major changes, please open an issue first.

## License

[MIT](LICENSE)

---

Made with ❤️ by [Coding Geh](https://github.com/Coding-Geh)
