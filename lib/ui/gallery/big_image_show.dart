import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigImageShow extends StatelessWidget {
  const BigImageShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SizedBox(
        child: Scaffold(
          body: Image(
            image: AssetImage("assets/images/8k/wallhaven-2.jpg"),
          ),
        ),
      ),
    );
  }
}
