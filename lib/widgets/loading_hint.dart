import 'package:flutter/material.dart';

class LoadingHint extends StatelessWidget {
  final String text;
  const LoadingHint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
