import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/screen/home.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  @override
  void initState() {
    super.initState();
    GoogleSignInHelper.googleSignIn.onCurrentUserChanged.listen(
        (GoogleSignInAccount? account) {
      if (account == null) {
        return;
      }
      GoogleSignInHelper.setAccount(account);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage(account: account)),
          (Route<dynamic> route) => false);
    }, onError: (error) {
      print('Error during user change: $error');
    });
  }

  /// Shows an AlertDialog with legal / policy links.
  void _showLegalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.appInformation),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.language),
              label: Text(AppLocalizations.of(context)!.selectLanguage),
              onPressed: () => _showLanguageSelectionDialog(context),
            ),
            const SizedBox(height: 10),
            Link(
              uri: Uri.tryParse('/service-agreement'),
              target: LinkTarget.blank,
              builder: (context, followLink) => ListTile(
                onTap: followLink,
                title: Text(AppLocalizations.of(context)!.serviceAgreement),
              ),
            ),
            Link(
              uri: Uri.tryParse('/privacy-policy'),
              target: LinkTarget.blank,
              builder: (context, followLink) => ListTile(
                onTap: followLink,
                title: Text(AppLocalizations.of(context)!.privacyPolicy),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          )
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    const availableLanguages = AppLocalizations.supportedLocales;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: availableLanguages.map((locale) {
            return RadioListTile<Locale>(
              title: Text(_getLanguageName(locale)),
              value: locale,
              groupValue: Localizations.localeOf(context),
              onChanged: (value) {
                if (value != null) {
                  // Update app language
                  Provider.of<SettingProvider>(context, listen: false)
                      .updateLanguage(value.languageCode);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.05, // 5% padding on left and right
                  vertical: screenHeight * 0.05, // 5% padding on top and bottom
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/1.png',
                              height:
                                  screenHeight * 0.25, // 25% of screen height
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.expenseTrackerSystem,
                            style: const TextStyle(
                              fontSize: 36,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Add app version text
                    Text(
                      AppLocalizations.of(context)!.appVersion,
                      style: const TextStyle(
                        fontSize: 14, // Reduced font size for better fit
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20), // Add some spacing
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      onPressed: GoogleSignInHelper.signIn,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image:
                                  AssetImage("assets/images/google_logo.png"),
                              height: 35.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .signInWithGoogle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  tooltip: AppLocalizations.of(context)!.appInformation,
                  onPressed: _showLegalDialog,
                  icon: const Icon(Icons.info),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
