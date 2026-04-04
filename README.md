# 📅 Event Planner App

A full-featured mobile event management application built with **Flutter**, backed by **Firebase**, following the **MVVM architecture** with **Provider** state management.

---

## ✨ Features

### 🔐 Authentication
- Email & password sign in / sign up
- Google Sign-In (OAuth 2.0)
- Password reset via email link
- Persistent session — app reopens on the last screen
- Secure logout with full back-stack clearing

### 📋 Event Management
- Create events with title, description, category, date, time, and map location
- 9 event categories: Sport, Birthday, Meeting, Gaming, Workshop, Book Club, Exhibition, Holiday, Eating
- Real-time event list powered by Firestore snapshots
- Edit and update existing events
- Delete events with confirmation dialog
- Events are user-scoped — each user sees only their own events

### 🗺️ Maps & Location
- Interactive Google Maps for selecting event location when creating an event
- Reverse geocoding to display a human-readable address from coordinates
- Live GPS location tracking in the dedicated Map tab
- Event details screen shows a full map preview pinned to the event's coordinates

### ❤️ Favourites
- Toggle favourite status on any event card
- Dedicated Favourites tab showing all saved events
- Real-time search within favourites by event title

### 👤 Profile
- Displays user's name, email, and location fetched from Firestore
- Profile photo upload from the device gallery — stored as base64 in Firestore (no cloud storage required)
- Avatar updates live in both the Profile screen and the Home AppBar

### 🌗 Theme
- Light and dark mode with full theme support across all screens
- One-tap toggle in the Home AppBar (sun ☀️ / moon 🌙 icon)
- Theme preference persisted with SharedPreferences — survives app restarts

### 🌍 Localisation
- English and Arabic support via easy_localization
- Right-to-left (RTL) layout support for Arabic
- Language preference persisted with SharedPreferences — survives app restarts

### 💅 UI/UX
- Adaptive splash screen for light and dark system themes (flutter_native_splash)
- Responsive layout with flutter_screenutil
- Custom themed dialogs for success, error, and confirmation actions
- Themed bottom sheet selectors for language and theme
- Category filter tabs with smooth selection state
- Theme-aware event card images (separate light/dark image sets)
- Custom floating action button with notch bottom navigation bar

---

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern:

```
lib/
├── core/
│   ├── Firebase-Firestore/         # Data layer
│   │   ├── models/                 # Event, UserModel
│   │   ├── firebase_utils.dart     # Firestore CRUD operations
│   │   └── firebase_auth_utils.dart# Auth operations
│   ├── utils/                      # App-wide constants
│   │   ├── app_assets.dart         # Image paths + theme-aware resolver
│   │   ├── app_colors.dart         # Colour palette + adaptive helpers
│   │   ├── app_routes.dart         # Named route constants
│   │   ├── app_styles.dart         # Text styles
│   │   ├── app_theme.dart          # Light & dark ThemeData
│   │   └── validators.dart         # Form field validators
│   └── widgets/                    # Reusable widgets
│       ├── custom_alert_dialog.dart# Themed loading & message dialogs
│       ├── custom_elevated_button.dart
│       ├── custom_text_form_field.dart
│       └── user_avatar.dart        # Base64 profile photo widget
│
├── view/                           # Screens (View layer)
│   ├── authetication/
│   │   ├── sign_in_screen.dart
│   │   ├── sign_up_screen.dart
│   │   └── forget_password_screen.dart
│   └── Home/
│       ├── bottom_nav_bar_wrapper.dart
│       ├── Home_Tab/
│       │   ├── home_tab_screen.dart
│       │   ├── Events/             # Create, Details, Update screens
│       │   └── widgets/            # EventItem, EventCategoryTabItem
│       ├── love_tab/               # Favourites screen
│       ├── map_tab.dart            # Live GPS map
│       └── Profile_Tab/            # Profile + bottom sheets
│
├── view_model/                     # Providers (ViewModel layer)
│   └── providers/
│       ├── app_provider.dart       # Location & map state
│       ├── event_list_provider.dart# Events CRUD + filter + favourites
│       ├── user_provider.dart      # User data + photo upload
│       ├── Theme_Provider/         # Theme + SharedPreferences
│       └── Language_Provider/      # Locale + SharedPreferences
│
├── firebase_options.dart
└── main.dart                       # Bootstrap + splash + providers
```

---

## 🛠️ Tech Stack

| Category | Package |
|---|---|
| Framework | Flutter (Dart) |
| Architecture | MVVM + Provider |
| Backend / DB | Firebase Firestore |
| Authentication | Firebase Auth + Google Sign-In |
| Maps | Google Maps Flutter + Location + Geocoding |
| State Management | Provider |
| Localisation | easy_localization |
| Persistence | SharedPreferences |
| Responsive UI | flutter_screenutil |
| Fonts | google_fonts |
| Splash Screen | flutter_native_splash |
| Image Picking | image_picker |
| Environment | flutter_dotenv |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.10.0`
- Dart SDK `>=3.0.0`
- A Firebase project with **Authentication** and **Firestore** enabled
- A Google Maps API key

### 1. Clone the repository

```bash
git clone https://github.com/Zahira-Hamza/event_planner_app.git
cd event_planner_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable **Email/Password** and **Google** sign-in methods under Authentication
3. Create a **Firestore** database and set the following rules:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /Users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /Events/{eventId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

4. Run `flutterfire configure` to generate `firebase_options.dart`

### 4. Set up environment variables

Create a `.env` file in the project root:

```env
SERVER_CLIENT_ID=your_google_server_client_id
```

> Get this from your Google Cloud Console → OAuth 2.0 Credentials → Web client.

### 5. Configure Google Maps

**Android** — add your API key to `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_MAPS_API_KEY"/>
```

**iOS** — add your API key to `ios/Runner/AppDelegate.swift`:
```swift
GMSServices.provideAPIKey("YOUR_MAPS_API_KEY")
```

### 6. Regenerate the splash screen

```bash
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

### 7. Run the app

```bash
flutter run
```

---

## 📁 Firestore Data Structure

```
Users/
  {uid}/
    id: string
    name: string
    email: string
    location: string
    photoUrl: string  (base64 data URL)

Events/
  {eventId}/
    id: string
    userId: string
    title: string
    description: string
    eventName: string   (category)
    image: string       (local asset path)
    dateTime: number    (milliseconds since epoch)
    time: string
    lat: number
    long: number
    isFavorite: boolean
```

---

## 📸 Screenshots

> Add your screenshots here.

| Sign In | Home | Event Details |
|---|---|---|
| ![](screenshots/sign_in.png) | ![](screenshots/home.png) | ![](screenshots/event_details.png) |

| Create Event | Map | Profile |
|---|---|---|
| ![](screenshots/create_event.png) | ![](screenshots/map.png) | ![](screenshots/profile.png) |

---

## 🔮 Roadmap

- [ ] Push notifications for upcoming events
- [ ] Share events with other users
- [ ] Calendar view for events
- [ ] Export events to Google Calendar

---

## 👩‍💻 Author

**Zahira Hamza**
[GitHub](https://github.com/Zahira-Hamza)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
