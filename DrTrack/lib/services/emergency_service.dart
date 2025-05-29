import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

import 'upload_to_imgbb.dart';
import 'get_location.dart';
import 'send_sms.dart';

Future<void> openDefaultSmsSettings() async {
  const intent = AndroidIntent(
    action: 'android.settings.MANAGE_DEFAULT_APPS_SETTINGS',
    flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
  );
  await intent.launch();
}

Future<void> triggerEmergencyFromNative(String frontPath, String backPath) async {
  try {
    final frontImage = File(frontPath);
    final backImage = File(backPath);

    // Upload images
    String? frontUrl = await uploadToImgBB(frontImage);
    String? backUrl = await uploadToImgBB(backImage);

    // Get live location URL
    String locationUrl = await getCurrentLocationUrl();

    // Combine everything in one alert message
    String message = "🚨 Emergency Alert!\n"
        "Location: $locationUrl\n"
        "Front Image: ${frontUrl ?? 'Not available'}\n"
        "Back Image: ${backUrl ?? 'Not available'}";

    // Send SMS to emergency contacts
    await sendEmergencySMS(
      msg: message,
      numbers: ['+923202085017', '+923202085017'],
    );
  } catch (e) {
    print("Emergency from native failed: $e");

    // Optionally prompt user to set default SMS app manually
    await openDefaultSmsSettings();
  }
}
