# MaryAir ✈️

A modern flight booking and parcel delivery application built with Flutter and Firebase.

## Features

### Customer Portal
- ✈️ **Flight Booking** - Book one-way or round-trip flights
- 💺 **Seat Selection** - Interactive seat map for all cabin classes
- 🎫 **E-Tickets** - Beautiful, branded digital tickets
- 📧 **Email OTP** - Secure authentication via email verification

### Staff Portal
- 📦 **Parcel Management** - Create and track parcel shipments
- 👥 **Client Booking** - Staff can book flights for customers
- 📊 **Operations Dashboard** - Real-time flight and parcel tracking

### Admin Dashboard
- 💰 **Revenue Tracking** - Real-time revenue from bookings and parcels
- ✈️ **Active Flights** - Monitor all active flight operations
- 👤 **User Management** - Manage user roles and permissions
- 📈 **Analytics** - Profit/loss calculations and metrics

## Technology Stack

- **Framework**: Flutter 3.10+
- **Backend**: Firebase (Auth, Firestore)
- **State Management**: Provider
- **Email**: Gmail SMTP (mailer package)
- **Currency**: Kenyan Shillings (KES)

## Pricing

### Flights
- Domestic (e.g., NBO-MBA): ~12,000 - 15,000 KES
- International: Variable based on route
- Baggage: 3,500 KES
- Insurance: 1,500 KES

### Parcels
- Base Rate: 2,500 KES
- Per Kg: 850 KES

## Getting Started

### Prerequisites
- Flutter SDK 3.10 or higher
- Android Studio / VS Code
- Firebase account

### Installation

1. Clone the repository
```bash
git clone https://github.com/michaelkitheka123/MaryAir.git
cd MaryAir
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` to `android/app/`
- Add your `firebase_options.dart` to `lib/`

4. Run the app
```bash
flutter run
```

## Building for Android

### Debug Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

```
lib/
├── models/          # Data models (User, Ticket, Parcel, etc.)
├── screens/         # UI screens
│   ├── auth/       # Login, Registration, OTP
│   ├── customer/   # Customer home, booking wizard
│   └── staff/      # Staff operations, admin dashboard
├── services/        # Business logic (Auth, Admin, etc.)
├── widgets/         # Reusable UI components
├── theme/          # App theme and styling
└── utils/          # Utilities and constants
```

## Configuration

### Email Settings
Email OTP is configured in `lib/services/auth_service.dart`:
- SMTP: Gmail
- Account: michael.mutemi16@gmail.com

### Android Configuration
- **minSdk**: 21 (Android 5.0+)
- **targetSdk**: 34 (Android 14)
- **Package**: com.maryair.maryair

## Features in Detail

### Booking Wizard
5-phase booking process:
1. Trip details (origin, destination, dates)
2. Flight selection with real-time pricing
3. Passenger information with passport photo
4. Payment (M-Pesa, Card)
5. E-ticket generation

### Admin Dashboard
Real-time metrics:
- Total Revenue (KES)
- Active Flights
- New Users (30 days)
- Profit/Loss estimates

### User Roles
- **Customer**: Book flights, view tickets
- **Pilot**: Flight operations
- **Staff**: Parcel management, client booking
- **Attendant**: Flight services
- **Admin**: Full system access

## Security

- Firebase Authentication
- Email verification required
- Role-based access control
- Secure password storage

## License

This project is proprietary software.

## Contact

**MaryAir Operations**
- Email: michael.mutemi16@gmail.com
- Tagline: "Where quality meets affordability"

---

Built with ❤️ using Flutter
