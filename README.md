# Chat App

A real-time, cross-platform chat application built with Flutter and backed by Firebase. It provides secure user authentication and instant messaging capabilities.

## Features

- **Real-time Messaging:** Leverages Firebase Cloud Firestore streams to send and receive messages instantly.
- **Firebase Authentication:** Secure user sign-up and login with email and password. Includes support for email verification and password reset functionality.
- **Message Management:** Users can edit or delete their own messages after they have been sent.
- **Clean & Animated UI:** A modern user interface with smooth, built-in animations for the login and sign-up screens.
- **BLoC for State Management:** Employs the BLoC pattern with Cubits for efficient, scalable, and predictable state management.
- **Cross-Platform:** Built with Flutter to run on Android, iOS, Web, and Desktop from a single codebase.

## Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/)
- **Backend:** [Firebase](https://firebase.google.com/)
  - **Firebase Authentication:** For user management.
  - **Cloud Firestore:** As the real-time NoSQL database for messages.
- **State Management:** [Flutter BLoC](https://bloclibrary.dev/) / Cubit
- **Architecture:** The project is structured following clean architecture principles, with a clear separation of concerns between the presentation (UI), business logic (Cubits), and data layers (Firebase services).

### Project Structure
The project is organized into the following main directories under `lib/`:

```
lib/
├── bussines_logic/     # BLoC/Cubit classes for state management
│   ├── auth/
│   └── messages/
├── data/               # Data layer including models and services
│   ├── models/
│   └── services/       # Firebase authentication and Firestore services
├── helpers/            # Utility functions and error handlers
├── presentation/       # UI Layer containing screens and widgets
│   ├── screens/
│   └── widgets/
└── main.dart           # Application entry point
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Firebase Configuration

1.  Create a new project on the [Firebase Console](https://console.firebase.google.com/).
2.  In the Firebase console, go to the **Authentication** section and enable the **Email/Password** sign-in method.
3.  Go to the **Firestore Database** section and create a new database.
4.  Register your applications (Android, iOS, Web, etc.) within your Firebase project settings.
5.  Follow the Firebase setup instructions to obtain your configuration files. You will need to use the FlutterFire CLI to configure your app:
    ```bash
    # Install the FlutterFire CLI
    dart pub global activate flutterfire_cli

    # Run the configure command in your project directory
    flutterfire configure
    ```
    This will automatically generate the `lib/firebase_options.dart` file and guide you through setting up platform-specific files like `google-services.json` for Android.

### Installation & Execution

1.  Clone the repository:
    ```bash
    git clone https://github.com/Moatasem-Official/Chat_App.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd chat_app
    ```
3.  Install the dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the application:
    ```bash
    flutter run
