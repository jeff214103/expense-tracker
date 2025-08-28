import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_web/screen/signin.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomScafold extends StatefulWidget {
  const CustomScafold({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.child,
    this.onLongPress,
    this.checkAuth = true,
  });

  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final Widget? child;
  final void Function()? onLongPress;
  final bool checkAuth;

  @override
  State<CustomScafold> createState() => _CustomScafoldState();
}

class _CustomScafoldState extends State<CustomScafold> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if (!widget.checkAuth) return;

    // Wait for the next frame to ensure the widget is mounted
    await Future.delayed(Duration.zero);
    if (!mounted) return;

    try {
      final authClient = await GoogleSignInHelper.googleSignIn.authenticatedClient();
      if (!mounted) return;

      if (authClient == null) {
        _handleNotAuthenticated();
      }
    } catch (e) {
      if (!mounted) return;
      _handleNotAuthenticated(isError: true);
    }
  }

  void _handleNotAuthenticated({bool isError = false}) {
    if (!mounted) return;
    
    Provider.of<SettingProvider>(context, listen: false).reset();
    
    // Navigate back to the login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const GoogleSignInPage()),
      (Route<dynamic> route) => false,
    );
    
    // Show appropriate message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isError 
              ? AppLocalizations.of(context)!.sessionTimeout 
              : AppLocalizations.of(context)!.notSignedIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: widget.leading,
        title: GestureDetector(
          onLongPress: widget.onLongPress,
          child: Text(
            widget.title.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        actions: widget.actions,
      ),
      body: widget.child,
    );
  }
}
