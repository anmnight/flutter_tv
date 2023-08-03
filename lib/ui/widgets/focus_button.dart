import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusButton extends StatelessWidget {
  const FocusButton({
    required this.label,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      ),
      onPressed: onTap,
      child: Row(
        children: [this.icon, const SizedBox(width: 10), Text(label)],
      ),
    );
  }
}
