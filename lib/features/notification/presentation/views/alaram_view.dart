import 'package:flutter/material.dart';

class AlaramView extends StatelessWidget {
  const AlaramView({super.key, this.payload});
  final String? payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Alarm View, the payload is $payload ')),
    );
  }
}
