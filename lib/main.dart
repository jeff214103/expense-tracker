import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/screen/privacy_policy.dart';
import 'package:expense_tracker_web/screen/service_agreement.dart';
import 'package:expense_tracker_web/screen/signin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        routes: {
          '/': (context) => const GoogleSignInPage(),
          '/privacy-policy': (context) => const PrivacyPolicyScreen(),
          '/service-agreement': (context) => const ServiceAgreementScreen(),
        },
      );
    });
  }
}
