import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/screen/privacy_policy.dart';
import 'package:expense_tracker_web/screen/service_agreement.dart';
import 'package:expense_tracker_web/screen/signin.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Expense Tracker',
      routes: {
        '/': (context) => const GoogleSignInPage(),
        '/privacy-policy': (context) => const PrivacyPolicyScreen(),
        '/service-agreement': (context) => const ServiceAgreementScreen(),
      },
    );
  }
}
