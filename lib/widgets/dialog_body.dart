import 'package:flutter/material.dart';

class LoadingDialogBody extends StatelessWidget {
  const LoadingDialogBody({Key? key, required this.text, this.actionButtons})
      : super(key: key);
  final String text;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 15,
            ),
            Text(text),
            Row(
              mainAxisSize: MainAxisSize.min,
              children:
                  (actionButtons == null) ? [const SizedBox()] : actionButtons!,
            )
          ],
        ),
      ),
    );
  }
}

class ConfirmationDialogBody extends StatelessWidget {
  const ConfirmationDialogBody(
      {Key? key, required this.text, this.actionButtons})
      : super(key: key);
  final String text;
  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children:
                  (actionButtons == null) ? [const SizedBox()] : actionButtons!,
            )
          ],
        ),
      ),
    );
  }
}

class AuthenticationDialogBody extends StatefulWidget {
  final String password;
  const AuthenticationDialogBody({Key? key, required this.password})
      : super(key: key);

  @override
  State<AuthenticationDialogBody> createState() =>
      _AuthenticationDialogBodyState();
}

class _AuthenticationDialogBodyState extends State<AuthenticationDialogBody> {
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Secret',
               
              ),
              obscureText: true,
              controller: passwordTextEditingController,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: const Text(
                    'Back',
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                FilledButton(
                  child: const Text(
                    'AUTHENTICATE',
                  ),
                  onPressed: () {
                    if (widget.password != passwordTextEditingController.text) {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialogBody(
                            text: "Incorrect Secret",
                            actionButtons: [
                              TextButton(
                                child: const Text(
                                  'Back',
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                      return;
                    }
                    Navigator.pop(context, true);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
