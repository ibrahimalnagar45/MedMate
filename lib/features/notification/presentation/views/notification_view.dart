import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, this.payload});
  final String? payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Notification Body  the payload is $payload')),
    );
  }
}
