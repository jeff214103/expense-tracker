import 'package:flutter/material.dart';

class CustomScafold extends StatelessWidget {
  const CustomScafold(
      {super.key,
      required this.title,
      this.actions,
      this.child,
      this.onLongPress});
  final String title;
  final List<Widget>? actions;
  final Widget? child;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GestureDetector(
            onLongPress: onLongPress,
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: actions,
        ),
        body: child);
  }
}
