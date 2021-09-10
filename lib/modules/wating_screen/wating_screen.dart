import 'package:flutter/material.dart';

class WatingScreen extends StatelessWidget {
  const WatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
