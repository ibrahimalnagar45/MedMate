import 'package:flutter/material.dart';
import 'package:midmate/features/settings/presentaion/views/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffD0DDE3),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: SettingsViewBody()),
    );
  }
}
