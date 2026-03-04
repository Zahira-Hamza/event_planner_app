# 📅 Evently — Event Management App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Google Maps](https://img.shields.io/badge/Google%20Maps-4285F4?style=for-the-badge&logo=google-maps&logoColor=white)
![Firestore](https://img.shields.io/badge/Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

A cross-platform event discovery and management application — find nearby events on the map, manage your own events in real-time, and stay organized with Firebase-powered sync.

</div>

---

## ✨ Features

- 🗺️ **Google Maps Integration** — View event locations on an interactive map with markers, venue search, and directions from your current location
- 📍 **Nearby Events** — Discover events happening around you using geolocation
- ➕ **Create & Manage Events** — Add, edit, and delete events with real-time Firestore sync across devices
- 🔥 **Real-Time Updates** — Changes reflect instantly for all users via Firebase Firestore live listeners
- 🔐 **User Authentication** — Secure sign-up, login, and profile management with Firebase Auth
- 📂 **Event Categories** — Browse events by type (concerts, sports, tech, social, etc.)
- 📆 **Event Details** — Full event info including date, time, location, description, and organizer

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter |
| Language | Dart |
| Backend & Database | Firebase Firestore |
| Authentication | Firebase Authentication |
| Maps | Google Maps SDK for Flutter |
| Location | Geolocator package |
| Real-time Sync | Firestore Streams |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A Firebase project ([console.firebase.google.com](https://console.firebase.google.com))
- A Google Maps API key ([console.cloud.google.com](https://console.cloud.google.com))

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Zahira-Hamza/event_planner_app.git

# 2. Navigate into the project
cd event_planner_app

# 3. Install dependencies
flutter pub get

# 4. Connect Firebase
# Add your google-services.json (Android) and GoogleService-Info.plist (iOS)
# to the respective platform directories

# 5. Add Google Maps API key
# Android: add to android/app/src/main/AndroidManifest.xml
# <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_KEY"/>

# 6. Run the app
flutter run
```

---

## 📁 Project Structure

```
lib/
├── core/               # Constants, themes, Firebase config
├── models/             # Event, User models
├── services/           # Firebase, Maps, Location services
├── screens/
│   ├── auth/           # Login, Register
│   ├── home/           # Event feed, categories
│   ├── map/            # Google Maps view
│   ├── detail/         # Event detail page
│   └── manage/         # Create & edit events
└── widgets/            # Event cards, map markers, loaders
```

---

## 📸 Screenshots

> *Coming soon — screenshots will be added here*

---

## 👩‍💻 Author

**Zahira Hamza** — Flutter Developer
- GitHub: [@Zahira-Hamza](https://github.com/Zahira-Hamza)
- LinkedIn: [zahira-hamza](https://linkedin.com/in/zahira-hamza-91b6ba379)
- Email: zahirahamza659@gmail.com
