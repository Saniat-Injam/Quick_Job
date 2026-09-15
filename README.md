# 💼 Quick Job — Professional Networking & Hiring Mobile Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-8B5CF6?style=for-the-badge)](https://pub.dev/packages/get)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20FCM-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Stripe](https://img.shields.io/badge/Stripe-Payments-6772E5?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com)
[![WebSockets](https://img.shields.io/badge/WebSockets-Realtime-000000?style=for-the-badge&logo=socketdotio&logoColor=white)](https://api.jobschatting.com)
[![ZegoCloud](https://img.shields.io/badge/ZegoCloud-Audio%2FVideo%20Calls-3B82F6?style=for-the-badge)](https://www.zegocloud.com/)

**Quick Job** is a cross-platform mobile application (iOS & Android) designed as a next-generation professional recruitment platform and LinkedIn-style networking app. Built with **Flutter**, **GetX**, and a **Feature-First Clean Architecture**, Quick Job bridges the gap between employers seeking top talent and professionals actively applying for roles.

---

## 🌟 Key Features Overview

### 👥 Dual-Role Ecosystem
* **Job Seeker Workflow**:
  * Customizable professional profile (skills, education, work experience, portfolio gallery).
  * PDF Resume/CV uploading (`syncfusion_flutter_pdfviewer`, `file_picker`), previewing, and management.
  * Smart job search with real-time keyword, category, and location filtering.
  * 1-Click job application process and real-time application status tracker (Applied, Under Review, Shortlisted, Rejected, Hired).
  * Profile liking/matching and saved/favorited job listings.

* **Employer Workflow**:
  * Enterprise employer dashboard with candidate pipeline analytics.
  * Full Job Post Management (Create, Edit, Activate/Deactivate, Delete job listings).
  * Candidate applicant screening with direct access to attached PDF resumes.
  * Application status updater (Shortlist/Reject/Hire notifications).

### 💬 Real-Time Messaging & Voice/Video Calling
* **WebSocket Instant Chat**: High-performance 1-on-1 direct messaging, conversation history, and real-time online status (`web_socket_channel`).
* **ZegoCloud HD Voice & Video Calls**: Integrated high-definition audio and video interviewing calls (`zego_uikit_prebuilt_call`) directly between employers and candidates.
* **Multimedia Exchange**: Fast image sharing and media upload support in chat (`dio`, `mime`).

### 📊 LinkedIn-Style Social Analytics & Engagement
* **Profile Visitor Tracking**: "Who Viewed Your Profile" visitor insights and candidate visibility analytics.
* **Profile Likes & Matches**: Mutual interest matching and social connection engine (`likeOrUnlike`).
* **Interactive Photo Gallery**: Multi-image profile gallery upload, update, and preview features.

### 💳 Subscription Monetization & Stripe Billing
* **Premium Membership Plans**: Tiered subscription packages for enterprise hiring features (`ChoosePlanScreen`).
* **Stripe Payment Gateway Integration**: In-app payment processing via `flutter_stripe` SDK with secure publishable key handling.

### 🔔 Push Notifications & Security
* **Firebase Cloud Messaging (FCM)**: Real-time background and foreground push notifications for incoming call invites, chat messages, and application updates.
* **Local Notifications**: `flutter_local_notifications` integration with custom channel sounds.
* **Robust Auth & Verification**: OTP Verification (`pinput`), Password Reset, Google Social Sign-In (`google_sign_in`), and encrypted JWT local storage (`get_storage`).

---

## 🏗 Architecture & Code Structure

The project follows a **Feature-First Modular Architecture** ensuring scalability, high code maintainability, and clean separation of concerns:

```
lib/
├── app.dart                    # Application root, theme configurations & GetMaterialApp setup
├── main.dart                   # Services initialization (Firebase, Stripe, Dotenv, FCM, ZegoCloud)
├── firebase_options.dart       # Firebase platform configuration
├── core/                       # Shared modules, services, and utilities
│   ├── bindings/               # ControllerBinder for global GetX dependency injection
│   ├── common/                 # Reusable widgets and UI components
│   ├── models/                 # Global data models
│   ├── services/               # AuthService, NetworkCaller, PaymentService, FCM & Local Notifications
│   └── utils/                  # App colors, sizer, theme tokens, validators, and AppUrls constants
├── features/                   # Independent feature modules
│   ├── auth/                   # Login, SignUp, OTP Verification, Password Reset, Google Auth
│   ├── chat/                   # Audio/Video Calls (ZegoCloud), WebSocket Chat, User Details
│   ├── employer_flow/          # Employer Dashboard, Job Creation, Applicant Lists
│   ├── job_seeker_flow/        # Job Search, Job Details, PDF Resume Upload, Application Tracking
│   ├── navbar/                 # Dynamic Navigation Bar based on user role
│   ├── notification/          # In-app Notification List & Push Handlers
│   ├── onboarding/             # Onboarding Slides & User Role Selection
│   ├── profile_flow/           # Profile Management, Premium Plans, Profile Visitors, Gallery Upload
│   ├── role/                   # Role switching state logic
│   └── splash_screen/          # Splash & Initial Auth Route Resolver
└── routes/                     # Named Routes & GetX Page mappings (app_routes.dart)
```

---

## 🛠 Tech Stack & Libraries

| Domain | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Language & SDK** | Flutter 3.x, Dart 3.x | Cross-platform iOS & Android mobile engine |
| **State & Navigation** | `get: ^4.7.3`, `get_storage: ^2.1.1` | Reactive state management, dependency injection & storage |
| **Real-Time Calling** | `zego_uikit_prebuilt_call`, `zego_uikit_signaling_plugin` | WebRTC 1-on-1 audio & video calling SDK |
| **Sockets & Messaging** | `web_socket_channel: ^3.0.3` | Real-time WebSocket connection for instant chat |
| **Push Notifications** | `firebase_messaging`, `flutter_local_notifications` | Background/Foreground push notifications and call alerts |
| **Authentication** | `firebase_auth`, `google_sign_in`, `pinput` | Social sign-in, JWT auth, and OTP verification UI |
| **Payments** | `flutter_stripe: ^12.1.1` | Credit card checkout & subscription payment SDK |
| **Document Processing** | `syncfusion_flutter_pdfviewer`, `file_picker` | In-app PDF resume rendering and file selection |
| **Networking & HTTP** | `dio: ^5.9.0`, `http: ^1.1.0` | Custom API caller, token refresh, and multipart uploads |
| **Environment** | `flutter_dotenv: ^6.0.0` | Secure environment variable configuration |
| **UI & Styling** | `google_fonts`, `shimmer`, `flutter_svg`, `animated_text_kit` | Modern aesthetics, smooth animations & dark/light theme |

---

## 🚀 Getting Started

### 📋 Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.9.2`)
* Dart SDK (`>=3.9.2`)
* Android Studio / Xcode (for device build target)
* Firebase Project setup with `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)

### 💻 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/Quick_Job.git
   cd Quick_Job
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables**:
   Create a `.env` file in the root directory based on `.env_example`:
   ```env
   PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
   Firebase_android_api_key=your_android_api_key
   Firebase_ios_api_key=your_ios_api_key
   Firebase_web_api_key=your_web_api_key
   ```

4. **Run the Application**:
   ```bash
   # Run on connected device or simulator
   flutter run
   ```

---

## 🤝 Key Engineering Takeaways

* Designed a **scalable GetX dependency injection system** using `ControllerBinder` to manage memory efficiency (`fenix: true`).
* Built a custom **Multipart Network Caller** for streaming large PDF resumes and profile images with progress tracking.
* Handles **asynchronous background WebRTC signals** with FCM background handlers, making video call invitations reliable across app states.
* Maintained clean code principles with zero hardcoded values, utilizing central `AppUrls`, `AppColors`, `AppTheme`, and `AppSizes`.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
