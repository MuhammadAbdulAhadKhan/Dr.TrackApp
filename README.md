# 📱 DR.Track - Smart Emergency Lifeline Beta Version

**DR.Track** is a Flutter-based emergency alert app designed to provide fast assistance in critical situations such as mobile snatching, female safety threats, and medical emergencies. The app uses quick trigger actions (like triple button presses) to capture essential information and notify emergency contacts immediately.

---

## 🚀 Features

- **Simulated Emergency Trigger (Triple Press)**
  - Captures photos from front and back cameras 📷
  - Fetches current location 📍
  - Sends details via SMS to emergency contacts ✉️

- **Multiple Emergency Modes**
  - ✅ Mobile Snatch Mode (Fully Functional)
  - ⏳ Female Safety Mode (Coming Soon)
  - ⏳ Medical Emergency Mode (Coming Soon)

- **Switch-based Activation**
  - Enable or disable each emergency mode
  - Requests necessary permissions (Camera, Location, SMS)

- **Modern UI Design**
  - Gradient header and cards
  - Snackbars with warnings, confirmations, and error handling
  - Google Fonts integration for better typography

---

## ⚠️ Current Limitations

- This app is in **beta**.
- Only the **Mobile Snatch Mode** is currently operational.
- Other modes will be activated in future updates.

---

## 📦 Dependencies

- [Flutter](https://flutter.dev/)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [permission_handler](https://pub.dev/packages/permission_handler)
- Custom services:
  - `capture_image.dart`
  - `emergency_service.dart`

---

## 🛠️ How to Use

1. Enable at least one emergency mode via the toggle switches.
2. Accept permissions when prompted.
3. Tap the **"Simulate Press x3"** button three times rapidly to trigger the emergency alert.
4. The app will capture photos, get your current location, and send SMS alerts to emergency contacts.

---

## 🔐 Permissions Required

- Camera (Front & Back)
- Location
- SMS

---

## 📅 Roadmap / Future Updates

- 🎯 Detect real hardware button triggers (power, volume)
- ☎️ Direct emergency calling & ambulance dispatch
- 🌐 Firebase backend integration for tracking/logging
- 🌍 Multilingual UI and enhanced UX design

---

## 📝 License

This project is currently in development and available under [Muhammad Abdul Ahad Khan].

---

Thank you for trying DR.Track! Your safety is our priority. 

---

**Developed with ❤️ using Flutter**

![DR TRACK](https://github.com/user-attachments/assets/db03cf17-9d40-42e2-9c60-be6a7754c189)
