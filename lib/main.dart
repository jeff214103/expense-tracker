import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/screen/privacy_policy.dart';
import 'package:expense_tracker_web/screen/service_agreement.dart';
import 'package:expense_tracker_web/screen/signin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:expense_tracker_web/services/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settings, child) {
      Locale locale = (settings.language == null)
          ? PlatformDispatcher.instance.locales.first
          : Locale(settings.language!);
      if (!AppLocalizations.supportedLocales.contains(locale)) {
        locale = const Locale('en');
      }
      return MaterialApp(
        title: 'Expense Tracker',
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          '/': (context) => const GoogleSignInPage(),
          '/privacy-policy': (context) => const PrivacyPolicyScreen(),
          '/service-agreement': (context) => const ServiceAgreementScreen(),
        },
      );
    });
  }
}
