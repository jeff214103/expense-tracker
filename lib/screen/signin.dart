import 'package:expense_tracker_web/screen/home.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/link.dart';
// import 'package:google_sign_in_web/google_sign_in_web.dart' as web;
// import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication error: $error')),
      );
    });
  }

  /// Shows an AlertDialog with legal / policy links.
  void _showLegalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Legal Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Link(
              uri: Uri.tryParse('/service-agreement'),
              target: LinkTarget.blank,
              builder: (context, followLink) => ListTile(
                onTap: followLink,
                title: const Text("Service Agreement"),
              ),
            ),
            Link(
              uri: Uri.tryParse('/privacy-policy'),
              target: LinkTarget.blank,
              builder: (context, followLink) => ListTile(
                onTap: followLink,
                title: const Text("Privacy Policy"),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
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
                          const Text(
                            'Expense Tracker System',
                            style: TextStyle(
                              fontSize: 36,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Add app version text
                    const Text(
                      'Version 1.0.6', // Update this to your app's version
                      style: TextStyle(
                        fontSize: 14, // Reduced font size for better fit
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20), // Add some spacing
                    // (GoogleSignInPlatform.instance as web.GoogleSignInPlugin)
                    // .renderButton()
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
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image:
                                  AssetImage("assets/images/google_logo.png"),
                              height: 35.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
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
                  tooltip: 'Legal Information',
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
