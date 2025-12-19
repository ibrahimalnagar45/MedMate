import 'package:flutter/material.dart';
import 'package:midmate/utils/services/shared_prefrence_service.dart';
import '../../data/models/ringtone_model.dart';
import '../../data/service/ringtone_service.dart';
import 'widgets/ringtone_tile.dart';

class RingtonePickerView extends StatefulWidget {
  const RingtonePickerView({super.key});

  @override
  State<RingtonePickerView> createState() => _RingtonePickerViewState();
}

class _RingtonePickerViewState extends State<RingtonePickerView> {
  late Future<List<RingtoneModel>> _ringtonesFuture;
  String? ringtoneUri;
  @override
  void initState() {
    super.initState();
    _ringtonesFuture = RingtoneService.getRingtones();
  }

  @override
  void dispose() {
    RingtoneService.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Ringtone')),
      body: FutureBuilder<List<RingtoneModel>>(
        future: _ringtonesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No ringtones found'));
          }

          final ringtones = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ringtones.length,
            itemBuilder: (context, index) {
              return RingtoneTile(
                ringtone: ringtones[index],
                onTap: () {
                  RingtoneService.play(ringtones[index].uri);
                  ringtoneUri = ringtones[index].uri;
                  SharedPrefrenceService.instance.prefs.setString(
                    SharedPrefrenceDb.ringtoneUri,
                    ringtoneUri ?? '',
                  );
                  setState(() {});

                  // the code to save the ringtone to the app
                },
              );
            },
          );
        },
      ),
    );
  }
}
