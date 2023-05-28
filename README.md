# Online Bazaar

An online bazaar web application.

<p>&nbsp;</p>

### Built With

[![Flutter][flutter-shield]][flutter-url]
[![Firebase][firebase-shield]][firebase-url]

<p>&nbsp;</p>

## Getting Started

- [Flutter 3.10.0 or above][flutter-url]
- [Android Studio 2022.1.1 or above][android-studio]
- [Xcode 14.2 or above][xcode]
- [Firebase CLI 11.27.0 or above][firebase-cli-url]
- [FlutterFire 0.2.7 or above][flutter-fire]

<p>&nbsp;</p>

## Installation

- Install and Set up [Flutter][flutter-install-url].
- Set up the the [IDE][flutter-ide-setup-url].
- Unzip the project archive.
- Go to the project directory.
  ```sh
  cd online_bazaar
  ```
- Install flutter packages.
  ```sh
  flutter pub get
  ```
- Create your Firebase project on Firebase Console
- Set up Auth, Firestore, Storage, and Remote Config using FlutterFire
- Create Firebase Remote Config parameters:

  - **event_name** _string_
  - **event_pickup_note** _string_
  - **event_start_at** _number_
  - **event_end_at** _number_

- Launch Android Simulator or iOS Simulator.
- Run the app
  - For Customer:
  ```sh
  flutter run --dart-define=USER_TYPE=customer
  ```
  - For Admin:
  ```sh
  flutter run --dart-define=USER_TYPE=admin
  ```
- _Optional_
  - To use Firebase App Check, add this argument:
  ```sh
  --dart-define=RECAPTCHA_KEY=your_app_check_recaptcha_key
  ```
  - To use Sentry, add this argument:
  ```sh
  --dart-define=SENTRY_DSN=your_sentry_dsn_url
  ```

<p>&nbsp;</p>

## Contact

[![LinkedIn][linkedin-shield]][linkedin-url]
[![Github][github-shield]][github-url]

[flutter-shield]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[flutter-url]: https://flutter.dev
[flutter-install-url]: https://docs.flutter.dev/get-started/install
[flutter-ide-setup-url]: https://docs.flutter.dev/get-started/editor
[android-studio]: https://developer.android.com/studio
[xcode]: https://developer.apple.com/xcode/
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://linkedin.com/in/irwancheung
[github-shield]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white
[github-url]: https://github.com/irwancheung
[firebase-shield]: https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white
[firebase-url]: https://firebase.google.com
[firebase-cli-url]: https://firebase.google.com/docs/cli
[flutter-fire]: https://firebase.google.com/docs/flutter/setup?platform=web#available-plugins
