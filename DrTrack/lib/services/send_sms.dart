import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

final Telephony telephony = Telephony.instance;

Future<void> sendEmergencySMS({
  required String msg,
  required List<String> numbers,
}) async {
  for (String number in numbers) {
    try {
      await telephony.sendSms(to: number, message: msg);
    } catch (e) {
      print("Failed to send SMS to $number: $e");

      await sendSmsIntent(msg, [number]);
    }
  }
}

Future<void> sendSmsIntent(String message, List<String> numbers) async {
  final uri = Uri(
    scheme: 'sms',
    path: numbers.join(','),
    queryParameters: {'body': message},
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    print('Could not launch SMS app');
  }
}

