import 'package:expense_tracker_web/screen/home.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        throw Exception('User is not logged in');
      }
      GoogleSignInHelper.setAccount(account);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(account: account),
        ),
      );
    }, onError: (error) {
      print('Error during user change: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication error: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
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
                          'assets/images/buymecoffee.png',
                          height: 200,
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
                          image: AssetImage("assets/images/google_logo.png"),
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
      ),
    );
  }
}
