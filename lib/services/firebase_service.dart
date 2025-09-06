
// lib/services/firebase_service.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:expense_tracker_web/firebase_options.dart';

class FirebaseService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAppCheck appCheck = FirebaseAppCheck.instance;

  Future<void> init() async {
    await appCheck.activate(
    webProvider: ReCaptchaV3Provider(DefaultFirebaseOptions.RecaptchaSiteID),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );
  }
}