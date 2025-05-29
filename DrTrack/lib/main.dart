import 'package:camera/camera.dart';
import 'package:drtrack/services/emergency_service.dart';
import 'package:drtrack/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeService(); // Start background service
  await availableCameras(); // Ensure camera list is available
  setupMethodChannel(); // Listen to native Android triggers

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dr Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF2F0FA)),
      ),
      home: SplashScreen(),
    );
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(),
  );

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('triggerEmergency').listen((event) async {});
  }
}

void setupMethodChannel() {
  const MethodChannel channel = MethodChannel('com.example.drtrack/emergency');

  channel.setMethodCallHandler((call) async {
    if (call.method == 'triggerEmergency') {
      final Map args = call.arguments;
      final String frontPath = args['front'];
      final String backPath = args['back'];
      await triggerEmergencyFromNative(frontPath, backPath);
    }
  });
}
