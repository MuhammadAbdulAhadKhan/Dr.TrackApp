import 'package:drtrack/services/capture_image.dart';
import 'package:drtrack/services/emergency_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeSCR extends StatefulWidget {
  const HomeSCR({super.key});

  @override
  State<HomeSCR> createState() => _HomeSCRState();
}

class _HomeSCRState extends State<HomeSCR> {
  final List<String> titles = [
    "MOBILE SNATCH",
    "FEMALE SAFETY",
    "MEDICAL EMERGENCY",
  ];
  final List<String> descriptions = [
    "If Simulate button is pressed 3 times, the phone will:\n\n• Capture photos from front and back cameras 📷\n• Fetch current location 📍\n• Send details via SMS to 2 emergency contacts ✉️",
    "Pressing the power button 3 times will:\n• Call emergency numbers 📞\n• Send your location and camera snapshots via SMS 📍📷",
    "In a serious health condition, pressing the volume button 3 times will:\n• Auto-call the emergency center ☎️\n• Request ambulance dispatch 🚑",
  ];
  final List<String> warning = [
    "If Simulate button is pressed 3 times, the phone will:\n\n• Capture photos from front and back cameras 📷\n• Fetch current location 📍\n• Send details via SMS to 2 emergency contacts ✉️",
    "🚧 This feature is not yet available as the app is still in development. Currently, only the first option is active ✅ in this beta version. 🔧 We're working hard to bring you the full experience in future updates. Thank you for your continued patience and support!",
    "🚧 This feature is not yet available as the app is still in development. Currently, only the first option is active ✅ in this beta version. 🔧 We're working hard to bring you the full experience in future updates. Thank you for your continued patience and support!",
  ];
  final List<String> emojis = ["📱", "👩‍🦰", "🚑"];
  List<bool> switchStates = [false, false, false];

  int pressCount = 0;
  DateTime? lastPress;

  void simulateTriggerPress() async {
    final isAnySwitchOn = switchStates.contains(true);

    if (!isAnySwitchOn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "Please enable at least one emergency mode.",
              style: TextStyle(color: Colors.red),
            ),
          ),
          backgroundColor: Color(0xFFFBC2EB),
        ),
      );
      return;
    }

    final now = DateTime.now();
    if (lastPress == null ||
        now.difference(lastPress!) > const Duration(seconds: 3)) {
      pressCount = 1;
    } else {
      pressCount++;
    }
    lastPress = now;

    if (pressCount >= 3) {
      pressCount = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🚨 Emergency Triggered"),
          backgroundColor: Colors.red,
        ),
      );

      try {
        final photos = await captureFrontAndBackPhotos();
        await triggerEmergencyFromNative(photos['front']!, photos['back']!);
      } catch (e) {
        debugPrint("Trigger failed: $e");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error capturing photos: $e')));
      }
    }
  }

  void _showModernSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFff758c), Color(0xFFff7eb3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "❌ $title has been turned OFF.",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Mobile Tracking",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "DR.Track Is Your Smart Emergency Lifeline",
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Just 3 Taps For Real-Time Tracking When Every Second Counts",
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              shadowColor: Colors.purple.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    emojis[index],
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(
                    titles[index],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5A4FCF),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      descriptions[index],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  trailing: Switch(
                    value: switchStates[index],
                    onChanged: (value) async {
                      if (value) {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(
                                  "Emergency Alert Setup 🔐",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: const Color(0xFF5A4FCF),
                                  ),
                                ),
                                content: Text(
                                  warning[index],
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xFF7E57C2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Text("Apply"),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ),
                        );

                        if (confirmed == true) {
                          Map<Permission, PermissionStatus> statuses =
                              await [
                                Permission.camera,
                                Permission.location,
                                Permission.sms,
                              ].request();

                          bool allGranted = statuses.values.every(
                            (status) => status.isGranted,
                          );

                          if (allGranted) {
                            setState(() => switchStates[index] = true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "⚠️ All permissions must be granted!",
                                  style: GoogleFonts.poppins(),
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            setState(() => switchStates[index] = false);
                          }
                        } else {
                          setState(() => switchStates[index] = false);
                        }
                      } else {
                        setState(() => switchStates[index] = false);
                        _showModernSnackBar(context, titles[index]);
                      }
                    },
                    activeColor: const Color(0xFF7E57C2),
                    inactiveThumbColor: Colors.grey.shade300,
                    inactiveTrackColor: Colors.grey.shade200,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: simulateTriggerPress,
        label: const Text("Simulate Press x3"),
        icon: const Icon(Icons.warning),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}
