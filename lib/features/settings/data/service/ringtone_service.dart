import 'package:jbh_ringtone/jbh_ringtone.dart';
import '../models/ringtone_model.dart';

class RingtoneService {
  static Future<List<RingtoneModel>> getRingtones() async {
    final ringtones = await JbhRingtone().getAllRingtones();

    return ringtones
        .map(
          (r) => RingtoneModel(title: r.title ?? 'Unknown', uri: r.uri ?? ''),
        )
        .toList();
  }

  static Future<void> play(String uri) async {
    await JbhRingtone().playRingtone(uri);
  }

  static Future<void> stop() async {
    await JbhRingtone().stopRingtone();
  }
}
