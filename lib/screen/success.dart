import 'package:flutter/material.dart';
import 'package:expense_tracker_web/screen/home.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  const SuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: 'SUCCESS',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(message),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              account:
                                  GoogleSignInHelper.googleSignIn.currentUser!,
                            )),
                    (Route<dynamic> route) => false);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
