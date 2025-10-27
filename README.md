# 💬 Chat App

A modern, real-time **Flutter Chat Application** powered by **Firebase Authentication** and **Cloud Firestore**.  
This app allows users to sign up, log in, and chat instantly in a clean and responsive UI.  
Built with **Flutter** and **Dart**, it’s designed for performance, simplicity, and scalability.

---

## 🎥 Demo

<img src="demo/notesappdemo.gif"  alt="Weather App Demo" />

---

## 🚀 Features

- 🔐 **Firebase Authentication** for secure login and signup  
- 💬 **Real-time messaging** powered by Firestore  
- 👤 **User-based message tracking** (sender & receiver)  
- ⚡ **Instant updates** without page refresh  
- 🧩 **Clean, responsive UI** with custom chat bubbles  
- ☁️ **Cloud-based message storage** for persistence  
- 📱 **Cross-platform support** for Android and iOS  

---

## 🧠 Technologies Used

| Category | Technology |
|-----------|-------------|
| Framework | Flutter |
| Language | Dart |
| Backend | Firebase Authentication, Cloud Firestore |
| Architecture | Stateless/Stateful Widgets |
| IDE | Android Studio / VS Code |

---

## 🏗️ Project Structure
```
lib/
│   constants.dart
│   firebase_options.dart
│   main.dart
│
├───helper
│       showsnackbar.dart
│
├───screens
│       chat_screen.dart
│       login_screen.dart
│       signup_screen.dart
│
├───services
│       firebase_services.dart
│
└───widgets
        chatbubble.dart
        custom_text_button.dart
        custom_text_field.dart

```

---

## ⚙️ How to Run

Follow these steps to set up and run the project locally:

1. **Clone the repository**
   ```bash
   git clone https://github.com/Hossam-Yaser/chatApp-Firebase.git
   ```

2. **Navigate to the project directory**
   ```bash
   cd chatApp-Firebase
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Set up Firebase**
   - Go to the [Firebase Console](https://console.firebase.google.com/)
   - Create a new project (or use an existing one)
   - Add an **Android** and/or **iOS** app to your project  
   - Enable the following Firebase services:
     - **Authentication** → Email/Password Sign-In
     - **Cloud Firestore** → Create a database in test or production mode
   - Download the configuration files:
     - `google-services.json` → place it in `android/app/`
     - `GoogleService-Info.plist` → place it in `ios/Runner/`
   - Update your `firebase_options.dart` file (generated automatically by `flutterfire configure`)

5. **Run the app**
   ```bash
   flutter run
   ```

6. *(Optional)* **Build a release APK**
   ```bash
   flutter build apk --release
   ```


---

## 💡 Future Improvements

- 📷 **Media Sharing** — Allow users to send images, videos, and voice notes.  
- 🔔 **Push Notifications** — Notify users instantly when they receive a new message.  
- 🧍‍♂️ **User Presence** — Show when a user is online, offline, or typing.  
- 💬 **Group Chats** — Enable users to create and join chat groups.  
- 🕒 **Message Status** — Add sent, delivered, and read indicators.  
- 🪄 **UI Enhancements** — Add animations, chat backgrounds, and better transitions.  
- 🧾 **Chat History Backup** — Allow exporting or syncing chat history across devices.  
- 🌐 **Localization** — Add support for multiple languages.
  

## 👨‍💻 About the Developer

**Hossam Yasser Abdelhady**  
📱 Cross-platform Mobile App Developer | Flutter | Dart  
💼 Passionate about creating modern, efficient, and user-friendly mobile applications.  

* 💼 [LinkedIn](https://www.linkedin.com/in/hossam-yasser-abdelhady/)
* 🐙 [GitHub](https://github.com/Hossam-Yaser)
* ✉️ Email: [hossamabdelhady000@gmail.com](hossamabdelhady000@gmail.com)



### ⭐ If you found this project helpful, don’t forget to star the repo!
